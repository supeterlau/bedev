defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do

  end
end

Advent.Day.exec()

