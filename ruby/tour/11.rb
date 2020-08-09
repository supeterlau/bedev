#!/usr/bin/ruby -w
# coding: utf-8

#run {
#  puts 'Hi block'
#}

#run

def test
  puts 'In method'
  yield
  yield :ok
  puts 'Back in method'
end

test { |x| puts "in block #{x}"}

def run(&func)
  puts "call block with &"
  func.call 3, 4
  yield 3, 5  # 可以调用
end

run {|x, y| puts "#{x**2 + y**2}"}
