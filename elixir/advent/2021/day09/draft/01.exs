defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
  end

  # basins_map = %{{i,j}=>index}
  # basins = %{1=>[]}
  def loop(row, col, data) do
    1..row
    |> Enum.reduce({%{},%{}}, fn j, {basins_map, basins} -> 
      1..col
      |> Enum.reduce({basins_map, basins}, fn i, {basins_map_1, basins_1} ->
        points = get_points(i,j, data)
        value = getv(i,j,data)
        if value >= 9 do
          {basins_map_1, basins_1}
        else
          case get_basin(points, {i,j}, basins_map_1) do
            {:new, _} -> 
              new_idx = length(Map.keys(basins_1))
              {
                Map.put(basins_map_1, {i,j}, new_idx), 
                Map.put(basins_1, new_idx, getv(i,j,data))
              }
            {idx, point} -> 
              point_v = getv(i,j,data)
              {
                Map.put(basins_map_1, point, idx),
                Map.update(basins_1, idx, 0, fn old -> old + point_v end)
              }
          end
        end
      end)
    end)
  end

  def getv(i,j,data), do: elem(data, j)|>elem(i)

  def get_points(i,j,data) do
    [{i,j},{i,j-1},{i-1,j}]
    |> Enum.filter(fn {i,j} -> getv(i,j,data) < 9 end)
  end

  def get_basin([], point, _), do: {:new, point}

  def get_basin(points, point, basins_map) do
points|> IO.inspect(charlists: :list)
    basins_map |> IO.inspect(label: "basins_map")
    case points |>  Enum.filter(&(Map.has_key?(basins_map, &1))) do
      [] -> {:new, point}
      inners ->
        idx = basins_map[inners|>hd()]
        {idx, point}
    end 
  end

  # def collect_basin_point(i, j, data, center,points, check_points) do
  #   new_points = [{i,j-1},{i,j+1},{i-1,j},{i+1,j}]
  #   |> Enum.map(fn {i,j} -> getv(i,j,data) end)
  #   |> Enum.filter(&(&1<9))
  #   |> Enum.reject(&(&1 in points))
  #   check_points = new_points ++ check_points
  #   if check_points != [] do
  #     [head | tail] = check_points
  #     [i,j] = head
  #     center = getv(i,j,data)
  #     collect_basin_point(i,j,data,center,points)
  #   end
  # end

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
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
