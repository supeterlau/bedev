#!/usr/bin/ruby -w

putc "Hello"

test_file = File.new("19-test-file", "a+")

if test_file
  test_file.syswrite(('a'..'z').to_a.join)
  test_file.each_byte {|ch| putc ch; putc ?.}
else
  puts "Open Failed"
end

test_file.close()

content = IO.readlines("19-test-file")
puts content[0]

some_file = "19-test-file"
puts File.size? some_file

puts Dir['./*'].inspect

require('tempfile')

f = Tempfile.new('test')
puts f.path
f.close
