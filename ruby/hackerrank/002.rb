def countingValleys(n, s)
  path = s.split('')
  level = []
  l = 0
  last_l = 0
  v_count = 0
  lhash = {"U"=>1, "D"=>-1}
  path.each do |t|
    last_l = l
    l += lhash[t]
    if l == 0 and last_l < 0
        v_count += 1
    end
    level.push(l)
  end
  v_count
end

puts countingValleys(8, 'UDDDUDUU')
puts countingValleys(8, 'UDDDUDUUUDDDUDUU')
puts countingValleys(8, 'UDDDUDUUUDDDUDUUUDDDUUDDUU')
