alias IO, as: MyIO
import IO

defmodule Demo do
  @moduledoc "Implements basic area"

  @pi 3.1415926

  def area(a), do: area(a, a)

  def area(a, b) do
    a * b
  end

  def sum(a, b \\0) do
    a + b
  end

  @doc "Computes area of a circle"
  def circle_area(r), do: r*r*@pi
end

Demo.area(4) |> MyIO.puts()

Demo.sum(100) |> IO.puts()

Demo.circle_area(10) |> puts()

# Code.fetch_docs(Demo) |> puts()
