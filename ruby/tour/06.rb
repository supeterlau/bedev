#!/usr/bin/ruby -w

puts 2**4

a = 10
b = 20

a, b = b, a

puts a, b

puts defined? foo
puts defined? a

DOG_COUNT = 0
module Dog
  DOG_COUNT = 10
  # 对常量赋值触发 warning
  ::DOG_COUNT = 20
  DOG_COUNT = 30
end

puts DOG_COUNT
puts Dog::DOG_COUNT
