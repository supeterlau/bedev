defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input3.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    risks = repeat(5)
    rows = tuple_size(risks)
    cols = tuple_size(risks|>elem(0))
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
      paths = paths
      |> filter(cols-1, rows-1)

      paths
      # |> IO.inspect(label: "paths")
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

  def add(risks, 0), do: risks

  def add(risks, n) do
    risks
    |> Enum.map(&(&1 |> Enum.map(fn value -> 
      next_value = value + n
      if next_value == 9 do
        9
      else
        rem(next_value, 9)
      end
    end)))
  end

  def repeat(n) do
    risks = parse_input()
            |> Enum.map(fn line -> 
              line
              |> String.split("", trim: true)
              |> Enum.map(&(Integer.parse(&1)|>elem(0)))
            end)
    # rcols = length(risks |> hd())
    rrows = length(risks)

    map = 0..2*(n-1)
    |> Enum.map(fn idx -> 
      {idx, add(risks, idx)}
    end)
    |> Enum.into(%{})

    0..n-1
    |> Enum.map(fn idx -> 
      rows = 0..n-1
      |> Enum.map(&Map.get(map, &1+idx))
      0..rrows-1
      |> Enum.map(fn idx -> 
        rows
        |> Enum.map(fn row -> Enum.at(row, idx) end)
        |> List.flatten()
        |> List.to_tuple()
      end)
    end)
    |> List.flatten()
    |> List.to_tuple()
  end

  def filter(paths, _cols, rows) do
    gap = 4
    border_ts = paths 
               |> Enum.filter(fn {{_,y},_} -> y==0 end)
               |> Enum.map(fn {{x, _},_} -> x end)
    border_bs = paths 
               |> Enum.filter(fn {{_,y},_} -> y==rows end)
               |> Enum.map(fn {{x, _},_} -> x end)

    cond do
      border_bs != [] ->
        border_b =  Enum.max(border_bs)
        paths
        |> Enum.filter(fn {{x, y},_} -> 
          y <= -x + rows + border_b and
          y >= -x + rows + border_b - gap and
          y >= 0 and
          y <= rows
        end)
      border_ts != [] ->
        border_t = Enum.max(border_ts)
        paths
        |> Enum.filter(fn {{x, y},_} -> 
          y <= -x + border_t and
          y >= -x + border_t - gap and
          y >= 0 and
          y <= rows
        end)
    end
    |> Enum.into(%{})
  end
end

# Advent.Day.repeat(5)
# |> IO.inspect(charlists: :list)

Advent.Day.exec()
|> IO.inspect(charlists: :list)
