defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
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
    find_paths([[start]], [], cols, rows)
    |> Enum.map(&path_sum(&1, risks))
    # |> Enum.map(fn path -> 
    #   {path_sum(path, risks), path}
    # end)
    # |> Enum.sort(fn {k1, _},{k2, _} -> k1<k2 end)
    # |> hd()
    |> Enum.min()
    |> Kernel.-(1)
  end

  def find_paths(cpaths, epaths, cols, rows) do
    {cpaths, new_epaths} = cpaths
    |> Enum.split_with(fn path -> 
      {x, y} = hd(path)
      x < cols-1 or y < rows - 1
    end)
    
    epaths = new_epaths ++ epaths
    if cpaths == [] do
      epaths
    else
      cpaths
      |> Enum.reduce([], fn path, paths -> 
        last = hd(path)
        new_paths = next(last, cols, rows) 
        |> Enum.map(&[&1 | path])
        new_paths ++ paths
      end)
      |> find_paths(epaths, cols, rows)
    end
  end

  def next({x, y}, cols, rows) do
    cond do
      x < cols-1 and y < rows-1 ->
        [{x+1, y}, {x, y+1}]
      x < cols-1 ->
        [{x+1, y}]
      y < rows-1 ->
        [{x, y+1}]
      true -> []
    end
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
