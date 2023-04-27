def repeatedString(s, n)
  sl = s.length
  times = n / sl
  rest = n - sl * times
  a_in_rest = 0
  i = 0
  while i < rest
    a_in_rest = s[i]=='a' ? a_in_rest + 1 : a_in_rest
    i += 1
  end
  if times == 0
      return a_in_rest
  end
  a_in_s = a_in_rest
  while i < s.length
    a_in_s = s[i]=='a' ? a_in_s + 1 : a_in_s
    i+=1
  end
  # p a_in_s, times, a_in_rest
  a_in_s * times + a_in_rest
end

puts repeatedString 'aba', 10
puts repeatedString 'a', 1000000000000
