class Book
  attr_writer :title
  attr_reader :author

  def initialize(title="what", author="who")
    @title = title
    @author = author
  end

  def what_am_i
    puts "This's a book!"
  end

  def to_s
    "#{@title} - #{@author}"
  end

  def self.fly
    "a book still want to fly"
  end
end

book = Book.new
puts book
book.what_am_i

book = Book.new("Ruby Deep Dive", "Noone")
puts book.author
puts book
book.title = "Good book"
puts book

puts Book.fly

# self, context

puts

def coffee
  puts self
end

coffee

class Shop
  def coffee
    puts self
  end
end

Shop.new.coffee

class Bus
  def do_drive
    banana = "variable"

    puts banana
    puts self.banana self
  end

  def banana(this)
    puts self == this
    "method"
  end
end

Bus.new.do_drive
