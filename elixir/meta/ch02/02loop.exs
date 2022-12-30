defmodule Ch02.Loop do
  defmacro while(expr, do: block) do
    quote do
      try do
        for _ <- Stream.cycle([:ok]) do
          if unquote(expr) do
            unquote(block)
          else
            # throw :break
            IO.inspect("break <---")
            # __MODULE__.break
            Ch02.Loop.break
          end
        end
      catch
        :break -> :ok
      end
    end
  end

  def break, do: throw :break

  defmacro infinite_while(expr, do: block) do
    quote do
      for _ <- Stream.cycle([:ok]) do
        if unquote(expr) do
          unquote(block)
        else
          # break
        end
      end
    end
  end
end
