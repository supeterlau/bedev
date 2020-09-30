class Developer
  define_method :frontend do |*my_arg|
    my_arg.inject(1, :*)
  end

  class << self
    def create_backend
      singleton_class.send(:define_method, "backend") do
        "Born from the ashes!"
      end
    end
  end
end

developer = Developer.new
p developer.frontend(2, 5, 10)
# => 100

# p Developer.backend
# undefined method 'backend' for Developer:Class (NoMethodError)

Developer.create_backend
p Developer.backend
# "Born from the ashes!"
