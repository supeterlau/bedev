#!/usr/bin/ruby -w

content = String.new "some new words"

puts content.downcase
puts content.upcase
puts content

puts "insert #{content}"

puts "whole".unpack "xax2aX2aX1aX2a"
