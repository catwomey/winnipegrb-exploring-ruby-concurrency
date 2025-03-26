# frozen_string_literal: true
def cpu_intensive_task(id)
  puts "Ractor #{id} starting"
  sum = 0
  1_000_000.times { sum += rand }
  puts "Ractor #{id} finished with sum: #{sum}"
  sum
end

ractor1 = Ractor.new {
  puts "Ractor 1 starting"
  sum = 0
  sum += Ractor.receive # block until a value is sent
  sum += Ractor.receive # block until a value is sent
  puts "Ractor 3 finished with sum: #{sum}"
  sum
}
ractor2 = Ractor.new { cpu_intensive_task(2) }
ractor3 = Ractor.new { cpu_intensive_task(3) }

result2 = ractor2.take
result3 = ractor3.take

puts "Main thread received results: #{result2}, #{result3}"
ractor1.send(result2)
ractor1.send(result3)
puts "Yielded ractor1 #{ractor1.take}"
