t = Thread.new { puts 10 ** 10 }
puts "Hello"
t.join

threads = []
10.times do |idx| 
  threads << Thread.new { puts 10 ** 10 * idx }
end

threads.each(&:join)

# fiber
puts

def callme
  puts %w(callme)
end

f1 = Fiber.new { puts 100 * 10; Fiber.yield; puts 200 * 10; Fiber.yield; callme}
f1.resume
f1.resume
f1.resume

factorial = 
  Fiber.new do
    count = 1

    loop do
      puts "count: #{count}"
      Fiber.yield (1..count).inject(:*)
      count += 1
    end
  end
puts factorial.resume
puts factorial.resume
puts factorial.resume

puts Array.new(5) { factorial.resume }
