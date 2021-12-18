# using Enum.reduce_while()

defmodule Advent.Day do
  def p1() do
    File.read!('./input.txt')
    |> String.split("\n")
    |> Enum.filter(&(&1!=""))
    |> Enum.reduce({nil, 0}, fn elem, {prev, count} -> 
      IO.inspect(count)
      count = count + (if is_nil(prev) or (String.to_integer(prev) > String.to_integer(elem)) do
        0
      else
        1
      end)
      {elem, count}
    end)
    |> IO.inspect()
  end

  def sum_window(window) do
    window|>Enum.map(&(String.to_integer(&1))) |> Enum.sum()
  end

  def exec(window_size \\ 1) do
    with data <- File.read!('./input.txt')
    |> String.split("\n")
    |> Enum.filter(&(&1!="")) do
      data
      |> Enum.reduce_while({[], 0, data}, fn _next, {window, count, rest} -> 
        new_window =Enum.take(rest, window_size)
        [_next | rest] = rest
        incr_by = if length(window) == 0 or sum_window(new_window) <= sum_window(window) do
          0
          else
          1
          end
        acc = {new_window, count+incr_by, rest}
        if length(rest) < window_size do
          {:halt, acc}
        else
          {:cont, acc}
        end
      end)
    end
    |> IO.inspect()
  end
end

Advent.Day.exec(1)
Advent.Day.exec(3)
