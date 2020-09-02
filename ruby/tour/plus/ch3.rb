puts (1..10).each {|x| x * 2}
(1..10).each {|x| puts x * 2}

# yield

def add_number(x)
  return "No block" unless block_given?
  30 + yield(33) + x + yield(x)
end

puts add_number(15) {|x|  x * 100 }

puts add_number(10) {|x| x - 100}

puts add_number(1)

def call_block(a, b, &block)
  a * b * block.call(a, b)
end

puts call_block(30, 40) {|a, b| a - b}

add = ->(args) {args.inject(:+)}
puts add.call([1,2,30])

proc = Proc.new {|x| puts x}
puts proc.lambda?
proc.call(10)

proc = Proc.new {|x| puts 1/x}
# puts proc.call(0)
proc.call(0.5)
# proc.call 不提供值，x 为 nil

a_lambda = -> { return 1 }
puts "lambda result: #{a_lambda.call}"
# a_proc = Proc.new {return 1} # raises a LocalJumpError exception.
# puts "proc result: #{a_proc.call}"

def we_call_proc
  puts "Before call proc"
  proc = Proc.new { return 3 }
  proc.call
  puts "After call proc"
end

p we_call_proc

add =->(x, y) {x + y}
puts add.call(3, 10)
# add = Proc.new {|x, y| x + y}
# puts add.call

call_by_number = lambda do |num|
  if num % 2 == 0
    return num
  end

  if num % 5 == 0
    return 
  end

  num * 2
end

coll = [32,3,43,5,7,6]
puts coll.map { |c| call_by_number.call(c) }.compact

def view_closure(proc)
  count = 500
  proc.call
end

def view_closure2(&proc)
  count = 500
  puts proc
  proc.call
end

count = 1
proc = Proc.new { puts count }
count = 2
puts "=> value of count 1:"
view_closure(proc)
puts "=> value of count 2:"
view_closure2 { puts proc }

def show_binding
  foo = 1000
  binding
end

puts show_binding.class
puts show_binding.eval('foo')
# self.foo = 100
# puts self.foo
