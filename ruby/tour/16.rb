#!/usr/bin/ruby -w

puts Time.new.inspect

puts Time.now.inspect

puts Time.now.zone

puts Time.now.to_a.inspect

puts Time.now.to_f

time = Time.new

puts time.to_s

puts time.ctime

puts time.localtime

puts time.strftime("%Y-%m-%d")

puts time - 10
