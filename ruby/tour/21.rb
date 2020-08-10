#!/usr/bin/ruby -w
# coding: utf-8

def run(token)
  type, value = token.shift
  case type
  when :add2 then 2 + value
  when :add3 then 3 + value
  else 10 + value
  end
end

# Ruby 1.9 之后可用 {add2: 10} {:add2 => 10}
puts run add2: 10

puts run add4: 10

class Box
  @@count = 0
  def initialize(w, h)
    @width, @height = w, h
    @@count += 1
  end

  def printWidth
    @width
  end

  def printHeight
    @height
  end

  def getWidth
    @width
  end

  def getHeight
    @height
  end

  private :getWidth, :getHeight

  def setWidth=(value)
    @width = value
  end

  def setHeight=(value)
    @height = value
  end

  def getArea
    @width * @height
  end

  def printArea
    puts "Box area: #{getArea}"
  end

  protected :printArea

  def self.printCount
    @@count
  end

  def to_s
    "(w:#@width;h:#@height)"
  end
end

box = Box.new 20, 30

puts "Width of box: #{box.printWidth}"
puts "Height of box: #{box.printHeight}"

box.setWidth = 100

puts "Width of box: #{box.printWidth}"
puts "Area of box: #{box.getArea}"

box2 = Box.new 12,13
puts "Counts of box: #{Box.printCount}"
# puts "Counts of box: #{box2.printCount}"
puts box2

box2.getArea
# box2.printArea

class Executable
  #puts "Type: #{self.type}"
  puts "Name: #{self.name}"
end
