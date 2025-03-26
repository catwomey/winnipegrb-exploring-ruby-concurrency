require 'benchmark'

client = -> (name, latency) do
  puts "#{name}: Starting"
  puts "#{name} response after " + Benchmark.realtime {
    start_time = Time.now
    while Time.now - start_time < latency
      IO.select(nil, nil, nil, 0.1) # Simulate non-blocking I/O
      Fiber.yield
    end
  }.to_s + " seconds"
end

result = Benchmark.realtime {
  fibers = []

  fibers << Fiber.new do
    client.call("Fiber 1", 3)
  end

  fibers << Fiber.new do
    client.call("Fiber 2", 0.25)
  end

  fibers << Fiber.new do
    client.call("Fiber 3",rand(0.25..1.5))
  end

  # Resume fibers to start them
  while fibers.any?(&:alive?)
    fibers.each do |fiber|
      fiber.resume if fiber.alive?
    end
  end
}

puts "Fiber blocking #{result} seconds"
