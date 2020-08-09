#!/usr/bin/ruby -w

names = Hash["cat"=>"Google", "dog"=>"Apple"]

puts names["cat"]

names.default="Amazon"

puts names["bird"]

puts names.key "Apple"

puts names.shift
