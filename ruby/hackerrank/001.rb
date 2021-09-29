# sock-merchant
# https://www.hackerrank.com/challenges/sock-merchant/problem

def sockMerchant(n, ar)
  # ar.tally.map{ |k, v| v / 2 }.sum
  count = {}
  ar.each {|v| count[v] == nil ? count[v] = 1 : count[v]+=1}
  puts count
  count.map{|k,v| v/2}.sum
end

puts sockMerchant(9, %w(10 20 20 10 10 30 50 10 20))
puts sockMerchant(7, [1,2,1,2,1,3,2])
