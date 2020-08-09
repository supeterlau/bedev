#!/usr/bin/ruby -w

module Hook
  PI = 3.14
  def Hook.add(m,n)
    m+n
  end

  def Hook.div(m,n)
    m/n
  end

  # def Hook.|>(m,n)
  #  m+n
  #end
end

module Ready
  def Ready.add(m,n)
    2**m+2**n
  end

  def Ready.div(m,n)
    2**m / 2**n
  end
end

puts Hook::add 4,5
puts Ready::add 4,5

module Week
  FIRST_DAY = 'Monday'
  def Week.weeks_in_month
    puts 'Four weeks in one month'
  end

  def Week.weeks_in_year
    puts '52 weeks in one year'
  end

  def from_mixins
    puts 'mixin works'
  end
end
