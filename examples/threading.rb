require 'benchmark'
require_relative 'client'
result = Benchmark.realtime {
        threads = []
        threads << Thread.new { Client::slow_client.call }
        threads << Thread.new { Client::variable_client.call }
        threads << Thread.new { Client::fast_client.call }
        threads.each(&:join)
      }

puts "Threaded #{result} seconds"
