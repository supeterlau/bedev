#!/usr/bin/ruby -w

x = 10

if x == 2 then
  puts "x is 2"
elsif x == 3
  puts "x is 3"
else
  puts "x is other value"
end

$debug = 1
print "debug mode\n" if $debug

# if not

unless x == 2
  puts "x is not 2"
else
  puts "x is 2"
end

$production = false
print "Not production mode\n" unless $production

$age = 5

case $age
when 0 .. 2
  puts "baby"
when 3 .. 6
  puts "little child"
when 7 .. 12
  puts "child"
when 13 .. 18
  puts "youth"
else
  puts "adult"
end
