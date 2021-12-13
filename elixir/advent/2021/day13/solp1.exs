defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def to_int(str) do
    str |> Integer.parse() |> elem(0)
  end

  def exec() do
    input = ~s(6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5)
    # {folds, points} = input |> String.split(~r{\n}, trim: true)
    {folds, points} = parse_input() 
                      |> Enum.split_with(&(&1 |> String.starts_with?("fold")))
    points = Enum.zip(points|> Enum.map(fn elem -> 
      [x,y] = elem |> String.split(",")
      {to_int(x), to_int(y)}
    end), List.duplicate("#", length(points)))
    |> Enum.into(%{})
    folds = folds |> Enum.map(fn fold -> 
      [_,_, kv] = fold |> String.split(" ", trim: true)
      [k, v] = kv |> String.split("=")
      {k, v |> Integer.parse() |> elem(0)}
    end)
|> IO.inspect(charlists: :list)
    # |> Enum.group_by(fn {k,_} -> k end)
    # |> Enum.map(fn {k, v} -> {k, v|>Enum.map(fn {_,v} -> v end)} end)
    # |> Enum.into(%{})
    # foldys = folds |> Map.get("y")
    # foldy = hd(foldys)

    # points
    # |> Enum.reduce(%{}, fn {{x, y}, v}, new_points_1 ->
    #   if y > foldy do
    #     new_points_1
    #     |> Map.put({x, 2*foldy-y}, "#")
    #   else
    #     new_points_1
    #     |> Map.put({x, y}, v)
    #   end
    # end)
    
    # folds
    [folds|>hd()]
    |> Enum.reduce(points, fn {k, fold}, new_points -> 
      new_points
      |> Enum.count() |> IO.inspect(label: "points count")
      case k do
        "x" ->
          new_points
          |> Enum.reduce(%{}, fn {{x, y}, v}, new_points_1 -> 
            if x > fold do
              new_points_1 
              |> Map.put({2*fold - x, y}, "#")
            else
              new_points_1
              |> Map.put({x, y}, v)
            end
          end)
        "y" ->
          new_points
          |> Enum.reduce(%{}, fn {{x, y}, v}, new_points_1 -> 
            if y > fold do
              new_points_1 
              |> Map.put({x, 2*fold-y}, "#")
            else
              new_points_1
              |> Map.put({x, y}, v)
            end
          end)
      end

    end)
    |> Enum.count()
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
