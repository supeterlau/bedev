defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input3.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    risks = parse_input()
            |> Enum.map(fn line -> 
              line
              |> String.split("", trim: true)
              |> Enum.map(&(Integer.parse(&1)|>elem(0)))
            end)
    cols = length(risks |> hd())
    rows = length(risks)
    risks = risks 
            |> Enum.map(&List.to_tuple(&1))
            |> List.to_tuple()
    start = {0, 0}
    find_paths(%{start => 0}, cols, rows, risks)
    # |> IO.inspect(charlists: :list)
    # |> Enum.sort(fn {_, v1},{_, v2} -> v1<v2 end)
  end

  def find_paths(paths, cols, rows, risks) do
    if {cols-1,rows-1} in Map.keys(paths) do
      paths 
      # |> IO.inspect(label: "last paths")
      |> Map.fetch!({cols-1, rows-1})
    else
      paths
      #|> IO.inspect(label: "paths")
      |> Enum.reduce(paths, fn {point, _}, paths1 -> 
        next(point, cols, rows, risks)
        #|> IO.inspect(label: "nexts")
        |> Enum.reduce(paths1, fn {point1, v1}, paths2 -> 
          point_v = Map.get(paths2, point)
          update_v = point_v+v1
          paths2
        #|> IO.inspect(label: "paths2")
          |> Map.update(point1, update_v, fn oldv -> if oldv > update_v, do: update_v, else: oldv end)
        end)
      end)
      |> find_paths(cols, rows, risks)
    end
  end

  def next({x, y}, cols, rows, risks) do
    # {x,y} |> IO.inspect(label: "point")
    [
      {x-1, y},
      {x+1, y},
      {x, y-1},
      {x, y+1},
    ] |> Enum.filter(fn {x,y} -> 
      x >= 0 and x <= cols-1 and y >= 0 and y <= rows-1
    end)
    # |> Enum.group_by(&(get_value(&1, risks)))
    # |> Enum.sort(fn {k1,_},{k2,_} -> k1 < k2 end)
    # |> hd()
    |> Enum.map(&{&1, get_value(&1, risks)})
  end

  def get_value({x, y}, risks) do
    elem(risks, y)
    |> elem(x)
  end

  def path_sum(path, risks) do
    path
    |> Enum.map(fn point -> get_value(point, risks) end)
    |> Enum.sum()
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
