queue = []

# push 到尾部

queue.push("xyz")

# unshift / prepend 添加到首部

queue.unshift("abc")
queue.unshift("def")
queue.unshift("ghi")

queue.prepend("jkl")

# unshift / prepend 添加到尾部

queue << "mno"

p queue

# pop 在尾部删除

queue.pop

p queue

que = Queue.new

que.push 10
que << 1
que << 2
que << 4

p que

p que.pop
p que.pop

que = SizedQueue.new(3)
que.push(1)
que.push(1)
que.push(1)

# 抛出 fatal No live threads left
# que.push(1)
# 抛出 queue full 错误 ThreadError
que.push(1, true)


# compare array Queue

puts '# compare array Queue'
one_q = []

# one_q.push 1
# one_q.push 2
# one_q.push 3

one_q.prepend 1
one_q.prepend 2
one_q.prepend 3

p one_q.pop
p one_q.pop
p one_q.pop

one_q = Queue.new

one_q.push 1
one_q.push 2
one_q.push 3

p one_q.pop
p one_q.pop
p one_q.pop

