defmodule Recursion do
  def print_multiple_times(msg, n) when n <= 1 do
    IO.puts msg
  end

  def print_multiple_times(msg, n) do
    IO.puts msg
    print_multiple_times(msg, n - 1)
  end
end

Recursion.print_multiple_times("Run", 5)


defmodule Math do
  # reduce
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end

  # map
  def double_each([head | tail]) do
    [head * 2 | double_each(tail)]
  end

  def double_each([]), do: []
end

Math.sum_list([3,4,5,6,3,2], 0) |> IO.puts
Math.double_each([3,4,5,6,3,2]) |> IO.inspect
