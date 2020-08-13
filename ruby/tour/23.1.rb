#!/usr/bin/ruby -w

count1 = count2 = 0
diff = 0

counter = Thread.new do
  loop do
    count1 += 1
    count2 += 1
  end
end

spy = Thread.new do
  loop do
    diff += (count1 = count2).abs
  end
end

sleep 1
puts "count1 : #{count1}"
puts "count2 : #{count2}"
puts "diff #{diff}"

mutex = Mutex.new

ncount1 = ncount2 = 0
ndiff = 0
ncounter = Thread.new do
  loop do
    mutex.synchronize do
      ncount1 += 1
      ncount2 += 1
    end
  end
end

nspy = Thread.new do
  loop do
    mutex.synchronize do
      ndiff += (ncount1 - ncount2).abs
    end
  end
end

sleep 1
mutex.lock
puts "ncount1: #{ncount1}"
puts "ncount2 #{ncount2}"
puts "ndiff: #{ndiff}"

