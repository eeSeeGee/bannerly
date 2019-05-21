module Interface
  def method(name)
    define_method(name) { |*args|
      raise "interface method #{name} not implemented"
    }
  end
end

# Generator processes an input string into a string consisting of ' ' and '#'.
module Generator
  extend Interface
  method :generate
end

