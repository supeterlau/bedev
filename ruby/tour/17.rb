#!/usr/bin/ruby -w

$, = ", "

range1 = (0..9).to_a
range2 = ("baa".."bar").to_a

puts "#{range1}"
puts "#{range2}"

digits = 0..9

puts digits.include? 9
puts digits.size
puts digits.max

puts %Q(digits reject: #{digits.reject {|d| d %2  == 0 }})
puts %q(digits reject: #{digits.reject {|d| d %2  == 0 }})

# while gets
#  print if /start/../end/
# end

score = 70

result = case score
         when 0..40 then "Fail"
         when 41..60 then "Pass"
         when 61..70 then "Pass with Merit"
         when 71..100 then "Pass with Distinction"
         else "Invalid score"
         end
puts result

if (('a'..'j') === 'z')
  puts "z in ('a'..'j')"
else
  puts "z not in ('a'..'j')"
end
