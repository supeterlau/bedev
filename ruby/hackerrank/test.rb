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
end

puts repeatedString 'aba', 7 
