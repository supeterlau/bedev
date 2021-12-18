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
      true ->
        []
        # Enum.zip(sx..ex, sy..ey)
    end
  end

  # points []
  def find_overlap(lines) do
    {_points, overlaps} = lines 
    |> Enum.reduce({[], []}, fn (data, {points, overlaps}) ->
      check_points = generate_points(data)
                     |> Enum.reject(&(&1 in overlaps))
      new_overlaps = check_points |> Enum.filter(&(&1 in points))
      new_points = check_points |> Enum.reject(&(&1 in points))
      remain_points = points |> Enum.reject(&(&1 in new_overlaps))
      all_points = remain_points ++ new_points
      all_overlaps = overlaps ++ new_overlaps
      {all_points, all_overlaps}
    end)
    # |> IO.inspect()
    overlaps |> Enum.count()
    # |> Enum.reject(&(&1 in overlaps))
  end

  def exec() do
    parse_input()
    |> find_overlap()
    |> IO.inspect()
  end
end

Advent.Day.exec()

