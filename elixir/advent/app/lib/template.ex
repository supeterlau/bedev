defmodule Advent.Day.Template do

  def log(item, label) do
    IO.inspect(item, charlists: :list, label: label)
  end

  def log(item) do
    IO.inspect(item, charlists: :list)
  end
   
  def parse_input(input) do
     File.read!(input) |> String.split(~r{\n}, trim: true)
  end

  def parse_input() do
    parse_input('./input1.txt')
    # parse_input('./input.txt')
  end

  def exec() do
    :ok
  end
end
