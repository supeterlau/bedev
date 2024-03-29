# using Enum.chunk_every()

defmodule Advent.Day do
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def sum_window(window) do
    window|>Enum.map(&(String.to_integer(&1))) |> Enum.sum()
  end

  def exec(window_size \\ 1) do
    parse_input()
    |> Enum.chunk_every(window_size, 1, :discard) 
    |> Enum.chunk_every(2, 1, :discard) 
    |> Enum.map(fn [prev, next] -> 
      if sum_window(prev) >= sum_window(next), do: 0, else: 1 
    end) 
    |> Enum.sum()
    |> IO.inspect()
  end
end

Advent.Day.exec(1)
Advent.Day.exec(3)
