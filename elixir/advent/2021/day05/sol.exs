defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def generate_points(data) do
    # 941,230 -> 322,849
    [sx,sy,ex,ey] = data|> String.split(~r/ -> |,/, trim: true) |> Enum.map(&Integer.parse(&1)|>elem(0))
    cond do
      sx == ex ->
        Enum.map(sy..ey, &{sx, &1})
      sy == ey ->
        Enum.map(sx..ex, &{&1, sy})
      abs(sx-ex) == abs(sy-ey) ->
        Enum.zip(sx..ex, sy..ey)
      true ->
        []
    end
  end

  # points %{}
  def find_overlap(lines) do
    lines 
    |> Enum.reduce(%{}, fn (data, points) ->
      data
      |> generate_points()
      |>Enum.reduce(points, fn point, points -> 
        Map.update(points, point, 1, fn value -> value + 1 end)
      end)
    end)
    |> Enum.count(fn {_, count} -> count > 1 end)
  end

  def exec() do
    parse_input()
    |> find_overlap()
    |> IO.inspect()
  end
end

Advent.Day.exec()

