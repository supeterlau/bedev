defmodule Mod do
  defmacro definfo do
    IO.puts "in macro's context (#{__MODULE__})"

    quote do
      IO.puts "in caller's context (#{__MODULE__})"

      def friendly_info do
        IO.puts """
        Module Name: #{__MODULE__}
        Module Functions are #{inspect __MODULE__.__info__(:functions)}
        """
      end
    end
  end

  def hygiene() do
    ast = quote do
      # if meaning_to_life == 42 do
      if var!(meaning_to_life) == 42 do
        "meaning to life is 42"
      else
        "meaning to life is not 42"
      end
    end
    Code.eval_quoted ast
    Code.eval_quoted ast, meaning_to_life: 42
  end
end

defmodule Caller do
  require Mod
  Mod.definfo
end
