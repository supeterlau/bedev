#!/usr/bin/ruby -w

cat = Array.new 5, "Pony"
puts "cat's name: #{cat}"

puts Array.new(5) {|e| e**2}

# puts cat * 10

numbers = Array(0..9)

puts numbers.delete('A') {puts 'no A'}

puts ['a','b','x'].map.with_index {|_, idx| idx}

puts numbers.zip(9..18).to_h
puts numbers.zip(9..18) {|a| a[0]+a[1]}
