require 'async'
require 'benchmark'
require_relative 'client'

result = Benchmark.realtime {
  Fiber.set_scheduler(Async::Scheduler.new)
  Fiber.schedule do
    Client.slow_client.call
  end

  Fiber.schedule do
    Client.fast_client.call
  end

  Fiber.schedule do
    Client.variable_client.call
  end

  Fiber.scheduler.run
}

puts "Fiber non blocking #{result} seconds"
