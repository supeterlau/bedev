def jumpingOnClouds(c)
  c = c.split(' ').map &:to_i
  if c.length == 2
    return 1
  end
  time = 0
  i = 0
  while i < c.length - 1
    if c[i] == 0
      time += 1
      if c[i+2] == 0
        i+=2
      else
        i+=1
      end
    else
      i+=1
    end
  end
  time
end

puts jumpingOnClouds('0 1 0') # 1
puts jumpingOnClouds '0 0 0 1 0 0'
puts jumpingOnClouds('0 0 1 0 0 1 0') # 4
puts jumpingOnClouds('0 0 1 0 0 1 0 0 0') # 5
puts jumpingOnClouds('0 0 0 0 1 0') # 3
