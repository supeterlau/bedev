defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def loop(row, col, data) do
    1..row
    |> Enum.reduce([], fn j, points -> 
      new_points = 1..col
      |> Enum.reduce([], fn i, points->
        center = getv(i,j,data)
        if is_lowest(i,j,data,center) do
          [center|points]
        else
          points
        end
      end)
      new_points ++ points
    end)
  end

  def getv(i,j,data), do: elem(data, j)|>elem(i)

  def is_lowest(i,j,data,center) do
    [{i,j-1},{i,j+1},{i-1,j},{i+1,j}]
    |> Enum.map(fn {i,j} -> getv(i,j,data) end)
    |> Enum.all?(&(&1>center))
  end

  def exec() do
    data = parse_input()
           |> Enum.map(fn line -> 
             row = String.split(line,"",trim: true) 
             |> Enum.map(&(Integer.parse(&1)|>elem(0)))
             [10] ++ row ++ [10]
           end)
    col = length(Enum.at(data, 0))
    data =[ List.duplicate(10, col)] ++ data ++ [List.duplicate(10, col)]
    row = data|>Enum.count()
    col = length(Enum.at(data, 0))
    data = data
           |> Enum.map(&(List.to_tuple(&1)))
           |> List.to_tuple()
    loop(row-2, col-2, data)
    |> Enum.map(&(&1+1))
    |> Enum.sum()
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
