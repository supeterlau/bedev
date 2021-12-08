defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{[^|]\n}, trim: true, include_captures: true)
    File.read!('./input.txt') 
    |> String.replace(~r{\|\n}, "| ")
    |> String.split(~r{\n}, trim: true)
  end

  def parse_digits(line) do
    [left, right] = line
    |> String.split(~r{ \|[\n ]}, trim: true)
    left
    |> String.split(~r{ }, trim: true)
    |> Enum.map(fn signal -> 
      {signal, Sting.length(signal)}
    end)
    |> Enum.into(%{})
  end

  def parse_right(line) do
    line
    |> String.split(~r{ \|[\n ]}, trim: true)
    |> Enum.at(1)
|> IO.inspect(charlists: :list)
    |> String.split(~r{ }, trim: true)
    |> Enum.map(&(String.length(&1)))
  end

  def exec() do
    uniq_numbers = [1, 7, 4, 8]
    uniq_number_patterns = [2, 3, 4, 7]
    parse_input()
    |> Enum.map(&(parse_right(&1)))
    |> Enum.map(fn list ->
      list
      |> Enum.filter(&(&1 in uniq_number_patterns))
      |> Enum.count()
    end)
    |> Enum.sum()
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
