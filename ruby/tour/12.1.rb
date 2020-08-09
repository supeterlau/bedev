#!/usr/bin/ruby -w

$LOAD_PATH << '.'

require('12')

# require_relative '12'

puts Hook::add 40,60
# puts Hook::|> 40,60

class Decade
  include Week
  number_of_yr = 10
  def number_of_months
    puts Week::FIRST_DAY
    number = 10 * 12
    puts number
  end
end

d1 = Decade.new
puts Week::FIRST_DAY
Week::weeks_in_month
d1.from_mixins
Wee::from_mixins
