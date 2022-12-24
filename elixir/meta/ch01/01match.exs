defmodule Main do
  defmodule Math do
    defmacro say({:+, _, [lhs, rhs]}) do
      quote do
        lhs = unquote(lhs)
        rhs = unquote(rhs)
        result = lhs + rhs
        IO.puts "#{lhs} plus #{rhs} is #{result}"
        result
      end
    end

    defmacro say({:*, _, [lhs, rhs]}) do
      quote do
        lhs = unquote(lhs)
        rhs = unquote(rhs)
        result = lhs * rhs
        IO.puts "#{lhs} times #{rhs} is #{result}"
        result
      end
    end
  end

  def run do
    require Math
    Math.say 5 + 2
    Math.say 4 * 8
  end

end

# Main.run()
