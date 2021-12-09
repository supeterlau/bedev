defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def loop(row, col,data) do
    1..row
    |> Enum.reduce({%{}, %{}}, fn j, {point_idx, idx_points} -> 
      1..col
      |> Enum.reduce({point_idx, idx_points}, fn i, {point_idx_1, idx_points_1} ->
        value = getv({i,j},data)
        if value >= 9 do
          {point_idx_1, idx_points_1}
        else
          {points, idx} = collect_points([{i,j}], [{i,j}], data, point_idx_1, nil)
          idx = if is_nil(idx), do: length(Map.keys(idx_points_1)), else: idx
          {
            Map.merge(Enum.zip(
              points,
              List.duplicate(idx, length(points))
            )|>Enum.into(%{}), point_idx_1),
            Map.update(idx_points_1, idx, points, fn old_points -> (points|>Enum.reject(&(&1 in old_points)))++old_points end)
          }
        end
      end)
    end)
  end

  def getv({i,j},data), do: elem(data,j) |> elem(i)

  def get_points({i,j}, data) do
    [{i,j},{i,j-1},{i-1,j},{i+1,j},{i,j+1}]
    |> Enum.filter(fn {i,j} -> getv({i,j},data) < 9 end)
  end

  def collect_points(check_points, points, data, point_idx, idx) do
    [point | tail] = check_points
    new_points = get_points(point, data) |> Enum.reject(&(&1 in points))
    points_in_map = new_points |> Enum.filter(&(Map.has_key?(point_idx, &1)))
    idx = if points_in_map != [], do: point_idx[points_in_map|>hd()], else: idx
    check_points = tail ++ new_points
    if check_points != [] do
      points = points ++ new_points
      collect_points(check_points, points, data, point_idx, idx)
    else
      {points, idx}
    end
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
    {_, basins}=loop(row-2, col-2, data)
    basins
    |>Map.values()
    |> Enum.map(&(length(&1)))
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.reduce(1, fn i, acc -> acc * i end)
    # |>Enum.map(fn elems -> 
    #   elems |> Enum.map(&(getv(&1, data)))
    #   |> Enum.sum()
    # end)
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
