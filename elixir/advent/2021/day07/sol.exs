defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n|,}, trim: true)
  end

  def fly(crabs) do
    map = crabs 
    |> Enum.group_by(&(&1)) 
    |> Enum.reduce(%{}, fn {k, v}, map ->
      Map.update(map, length(v), [k], fn old -> [k|old] 
      end)
    end)
    map[Map.keys(map)|>Enum.max()]
    |> Enum.map(fn elem -> 
      crabs
      |> Enum.map(&(abs(&1-elem)))
      |> Enum.sum()
    end)
    |> Enum.min()
  end

  def cal_fuel1(stop, start), do: abs(stop-start)

  def cal_fuel2(stop, start) do
    case abs(stop-start) do
      0 -> 0
      steps ->
        div(steps * (steps+1), 2)
    end
  end

  def crabs_range(crabs), do: Enum.min(crabs)..Enum.max(crabs)

  def exec(crabs) do
    crabs_range(crabs)
    |> Enum.map(fn elem -> 
      crabs
      |> Enum.map(&(cal_fuel1(&1, elem)))
      # |> Enum.map(&(cal_fuel2(&1, elem)))
      |> Enum.sum()
    end)
    |> IO.inspect(charlists: :list)
    |> Enum.min()
  end

  def exec() do
    parse_input()
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
    |> exec()
  end
end

# Advent.Day.exec([16,1,2,0,4,2,7,1,2,14,1,0,0,100,100,100,100])
Advent.Day.exec([16,1,2,0,4,2,7,1,2,14])
# Advent.Day.exec()
|> IO.inspect()

# Advent.Day.fly([16,1,2,0,4,2,7,1,2,14,1,0,0,100,100,100,100])
# |> IO.inspect()
