# https://github.com/ruby-concurrency/concurrent-ruby
require 'concurrent'
require 'benchmark'
require_relative 'client'

result = Benchmark.realtime {
  Concurrent::Promise.all?(
    Concurrent::Promise.execute { Client::slow_client.call },
    Concurrent::Promise.execute { Client::variable_client.call },
    Concurrent::Promise.execute { Client::fast_client.call }
  ).execute.wait
}.to_s
puts "Concurrent #{result} seconds"
