defmodule ControlFlow do
  defmacro unless(expr, do: block) do
    quote do
      if !unquote(expr), do: unquote(block)
    end
  end
end


defmodule Main do
  def run do
    require ControlFlow

    ControlFlow.unless 2 == 5, do: IO.puts "enter block(2==5)"
    ControlFlow.unless 5 == 5, do: IO.puts "enter block(5==5)"
  end
end

Main.run()
