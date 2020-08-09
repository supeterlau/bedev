#!/usr/bin/ruby -w

def test(a1 = "Ruby", a2 = "Perl")
  puts "This PL is #{a1}"
  puts "This PL is #{a2}"
  _x = 100
end

test "C", "C++"
puts test

def variable_test(*args)
  puts "Number of parameters: #{args.length}"
  (0...args.length).each do |i|
    puts "Parameters is #{args[i]}"
  end
end

variable_test "Mac", "36", "M", 100

class Account
  def charge
    100
  end

  def Account.charge
    200
  end
end

puts Account.charge
puts Account.new.charge

def bar
  100.1
end

puts bar
undef bar
puts bar
