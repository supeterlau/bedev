class MySet
  attr_reader :items

  def initialize()
    @items = []
  end

  def push(item)
    items.push(item) unless items.include?(item)
  end
end

set = MySet.new
set.push("apple")

new_set = MySet.new
new_set.push("pie")

set.push("apple")
print set.items
new_set.push("apple")
print new_set.items
