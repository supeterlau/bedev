class Developer
  def self.backend
    "I am a backend developer"
  end

  def frontend
    "I am a frontend developer"
  end
end

puts Developer.class
puts Developer.class.superclass
puts Developer.class.superclass.superclass
puts Developer.class.superclass.superclass.superclass

example = "A string object"
def example.what
  self.upcase
end

puts example.what

class << example
  def where
    self.upcase + " DONE"
  end
end

puts example.where

class Developer
  class << self
    def devops
      "a devops"
    end
  end

  def self.backend
    _ = "I am a backend developer"
    puts "In class method: self = " + self.to_s
  end

  def Developer.ai
    "I am a ai"
  end

  def frontend
    _ = "I am a frontend developer"
    puts "In instance method: self = " + self.to_s
  end
end

class Object 
  def meta_example
    class << self 
      self 
    end 
  end 
end 

puts Object.meta_example

developer = Developer.new
developer.frontend

Developer.backend

puts 'In metaclass: self = ' + developer.meta_example.to_s

p developer.class.singleton_class.instance_methods false

class Developer
end

Developer.instance_eval do
  p "instance_eval - self : " + self.to_s
  def backend
    p "inside method: " + self.to_s
  end
end

Developer.backend

Developer.class_eval do
  p "class_eval self: " + self.to_s
  def frontend
    p 'inside method self: ' + self.to_s
  end
end

p developer = Developer.new
developer.frontend

class Web

  define_method :frontend do |*arg|
    arg.inject(1, :*)
  end

  def create_ai
    singleton_class.send(:define_method, "ai") do
      "Create ai method"
    end
  end

  class << self
    def create_backend
      singleton_class.send(:define_method, "backend") do
        "Create backend method"
      end
    end
  end

  # Not DRY code 

  def coding_frontend
    p "writing frontend"
  end

  def coding_backend
    p "writing backend"
  end

  # DRY
  [
    'new_fe',
    'new_be'
  ].each do |method|
    define_method "#{method}" do 
      p "create " + method.to_s
    end
  end

  def method_missing method, *args, &block
    return super(method, *args, &block) unless method.to_s =~ /^coding_\w+/
    self.class.send(:define_method, method) do
      p 'Writing ' + method.to_s.gsub(/^coding_/, '').to_s
    end
    self.send(method, *args, &block)
  end

  def add(x, y)
    x + y
  end
  private :add
end

web = Web.new
p web.frontend(2, 5, 10)
# p web.backend
Web.create_backend 
p Web.backend

web.create_ai
p web.ai

web.coding_frontend 
web.coding_backend

web.new_fe
web.new_be

web.coding_debug

# p web.add(8,90)
p web.send(:add, 8, 90)
