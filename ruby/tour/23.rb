#!/usr/bin/ruby -w

def runner1
  i=0
  while i <= 2
    puts "runner1 at: #{Time.now}"
    sleep(2) 
    i = i+1
  end
end

def runner2
  j=0
  while j <= 2
    puts "runner2 at: #{Time.now}"
    sleep(1)
    j=j+1
  end
end

puts "Started At #{Time.now}"
t1 = Thread.new{runner1}
t2 = Thread.new{runner2}
t1.join
t2.join
puts "End At #{Time.now}"

puts "Run part 2"

count = 0
threads = []

10.times do |i|
  threads[i] = Thread.new {
    sleep(rand(0)/10.0)
    Thread.current['count'] = count
    count += 1
  }
end

threads.each {|t| t.join; print t['count'], ", "}
puts "count = #{count}"

