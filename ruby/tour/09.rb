#!/usr/bin/ruby -w

# Loops

$i = 0
$num = 5

while $i < $num do
# while $i < $num
# while $i < $num ;
# while $i < $num \\
  puts("inside loop i = #$i")
  $i += 1
end

$i2 = 1
$num2 = 6
begin
  puts("modifier while i = #$i2")
  $i2 += 2
end while $i2 < $num2

for i in 0..5
  puts "Value of local variable is #{i}"
end

for i in 0..5
  if i > 2 then
    puts "i is #{i}"
    redo
  end
  i += 1
end
# for i in 0..5
#    retry if i > 2
#    puts "Value of local variable is #{i}"
# end
# for i in 9..19
#   retry if i >= 11
#   puts "i = #{i}"
# 
# end
