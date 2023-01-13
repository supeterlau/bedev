defmodule Main do
  def convert({first, _, [lhs, rhs]}) do
    result = "(#{convert(first)} #{convert(lhs)} #{convert(rhs)})" 
    IO.puts result |> String.replace(":", "")
    result
  end

  def convert(first) do
    first |> inspect()
  end

  def convert() do
    # endpoint
    # convert(quote do: Enum.map(&(&1*2), [1,2,3]))
    IO.puts "(+ (- (* 5 2) 1) 7)"
    convert(quote do: (5*2)-1+7)
    # convert(quote do: 2+3)
  end

  # fix ast
  def fix() do
    # atom, keyword list, list
    ast = quote do
      number * 10
    end
    fix(ast, {:number, 5})
  end

  def fix({func, env, [lh, rh]}, {key, value}) do
    case lh do
      {^key, _, _} -> 
        {func, env, [value, rh]}
      _ -> fix(lh, {key, value})
    end
  end
end

# Main.convert()
