defmodule Advent.Day do

  def log(item, label) do
    IO.inspect(item, charlists: :list, label: label)
  end

  def log(item) do
    IO.inspect(item, charlists: :list)
  end
   
  def parse_input() do
     File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do

  end
end

Advent.Day.exec()
|> Advent.Day.log()
