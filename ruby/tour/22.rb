#!/usr/bin/ruby -w

line1 = "cats are smarter than dog"
line2 = "dogs also like meat"

if line1 =~ /cats(.*)/
  puts "line1 contains cat"
end

if line2 =~ /dogs(.*)/
  puts "line2 contains dog"
end

text = "rails are rails, really good Ruby on Rails"

text.gsub!('rails', 'Rails')

puts text

text = "rails are rails, really good Ruby on Rails"

text.gsub!(/\brails\b/, 'Rails')

puts text
