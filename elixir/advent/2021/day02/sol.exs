defmodule Advent.Day do
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def p1() do
    {hp, depth} =  
      parse_input() 
      |> Enum.reduce({0, 0}, fn 
        "forward " <> move, {hp, depth} -> 
         {hp+String.to_integer(move), depth}
        "up " <> move, {hp, depth} -> 
          {hp, depth-String.to_integer(move)}
        "down " <> move, {hp, depth} -> 
          {hp, depth+String.to_integer(move)}
     end)
     |> IO.inspect()
    IO.inspect(hp*depth)
  end

  def exec() do
    {hp, depth, _} =  
      parse_input() 
      |> Enum.reduce({0, 0, 0}, fn 
        "forward " <> move, {hp, depth, aim} -> 
          {hp+String.to_integer(move), depth+String.to_integer(move)*aim, aim}
        "up " <> move, {hp, depth, aim} -> 
          # {hp, depth-String.to_integer(move), aim-String.to_integer(move)}
          {hp, depth, aim-String.to_integer(move)}
        "down " <> move, {hp, depth, aim} -> 
          # {hp, depth+String.to_integer(move), aim+String.to_integer(move)}
          {hp, depth, aim+String.to_integer(move)}
     end)
     |> IO.inspect()
    IO.inspect(hp*depth)
  end
end

# horizontal position

Advent.Day.exec()
