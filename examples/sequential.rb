require_relative 'client'
require 'benchmark'

result = Benchmark.realtime {
  Client::slow_client.call
  Client::variable_client.call
  Client::fast_client.call
}.to_s

puts "Sequential #{result} seconds"
