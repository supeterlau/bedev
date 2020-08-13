#!/usr/bin/ruby -w

mutex = Mutex.new

cv = ConditionVariable.new

c1 = Thread.new {
  mutex.synchronize{
    puts "A: critical section, wait for cv",
    cv.wait(mutex)
    puts "A: critical section again, I rule!"
  }
}

puts "(Later)"

c2 = Thread.new {
  mutex.synchronize {
    puts "B: critical, done with cv"
    cv.signal
    puts "B: critical, finishing up"
  }
}

c1.join
c2.join
