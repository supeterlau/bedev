#!/usr/bin/ruby -w

puts "Hello, Awesome Ruby!"
puts __FILE__+__LINE__.to_s

# 执行命令
print <<`EOC`
echo Hello
EOC

print <<"foo", <<"bar"
I said foo.
foo
        I said bar.
bar

END {
  puts "This is the end"
}

BEGIN {
  puts "Running before all other codes."
}
