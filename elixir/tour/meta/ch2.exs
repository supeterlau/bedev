defmodule Tour do
  defmodule Unless do
    def fun_unless(clause, do: expression) do
      if(!clause, do: expression)
    end

    # require Tour.Unless 后才能用 macros
    defmacro macro_unless(clause, do: expression) do
      quote do
        if(!unquote(clause), do: unquote(expression))
      end
    end
  end

  defmodule Hygiene do
    defmacro no_interference do
      # quote do: a = 1
      # 如果想影响到 context 要用 var!(a)
      quote do: var!(a) = 1
    end
  end

  defmodule HygieneTest do
    def go do
      require Hygiene
      a = 20
      Hygiene.no_interference()
      a
    end
  end

  defmodule Sample do
    defmacro initialize_to_char_count(variables) do
      Enum.map variables, fn(name) ->
        var = Macro.var(name, nil)
        length = name |> Atom.to_string |> String.length
        # TODO: vim plugin indent error
        quote do
          unquote(var) = unquote(length)
        end
      end
    end
  end

  def run() do
    require Unless
    Unless.macro_unless true, do: IO.puts "skip text"
    Unless.fun_unless true, do: IO.puts "also skip"

    IO.puts("quoted expression input")
    expr = (quote do: Unless.macro_unless(true, do: IO.puts "skip text"))
           |> IO.inspect(label: "expr")
    res = Macro.expand_once(expr, __ENV__) 
          |> IO.inspect(label: "res")
    res |> Macro.to_string

    HygieneTest.go

    require Sample
    Sample.initialize_to_char_count [:red, :green, :yellow]
    [red, green, yellow]

    [
      __ENV__.module,
      __ENV__.file,
      __ENV__.requires,
      (require Integer;__ENV__.requires)
    ]
  end
end

Tour.run |> IO.inspect
