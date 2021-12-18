defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n|,}, trim: true)
  end

  def start(state, 0) do
    state
    # |> IO.inspect()
  end

  def start(init, days) do
    {init, new} = init 
    |> Enum.reduce({[],[]}, fn fish, {init, new} -> 
      {init, new} = cond do
        fish == 0 -> 
          {[6|init], [8|new]}
        fish > 0 -> 
          {[fish-1|init], new}
      end
      # |> IO.inspect()
      {init, new}
    end)
    start(Enum.reverse(init) ++ Enum.reverse(new), days-1)
  end

  def exec(init, days) when is_list(init) do
    init = init
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
    start(init, days)
  end

  def exec(init, days) do
    exec(init|> String.split(",", trim: true), days)
  end

  def exec(days), do: exec(parse_input(), days)

  def exec(), do: parse_input()

  def cal(number, numbers \\ [])

  def cal(0, numbers) do
    numbers |> Enum.reverse
  end

  def cal(number, []) when number >= 2 do
    numbers = [number-2, number]
    cal(number-2, numbers)
  end

  def cal(_, []), do: [0, 1]

  def cal(number, numbers) do
    cal(number-1, [number-1 | numbers])
  end
end

Advent.Day.exec("3,4,3,1,2", 18) 
|> IO.inspect(charlists: :list)

# [2,3,2,0,1] = Advent.Day.exec("3,4,3,1,2", 1)
# [1,2,1,6,0,8] = Advent.Day.exec("3,4,3,1,2", 2)
# [6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8] = Advent.Day.exec("3,4,3,1,2", 18)
# Advent.Day.exec("3,4,3,1,2", 80) 
# |> length()
# |> IO.inspect()

# Advent.Day.exec("3,4,3,1,2", 256) 
# Advent.Day.exec(80)

#Advent.Day.exec("6", 7*4) 
#|> IO.inspect()
#|> length()
#|> IO.inspect()
# Advent.Day.exec("6", 7) 
# Advent.Day.exec("6", 7*2) 
# Advent.Day.exec("6", 7*3) 
# Advent.Day.exec("6", 7*4) 
# Advent.Day.exec("6", 7*3) 
# Advent.Day.cal(5) + 1
# Advent.Day.cal(49)
# |> IO.inspect()
# |> IO.inspect(charlists: :list)
