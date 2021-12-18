defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n|,}, trim: true)
  end

  def start(init, days, total \\ 0) do
    {next, total} = init
    |> Enum.reduce({[], total}, fn fish, {next,total} -> 
      cond do
        fish == 0 -> 
          {[6 | next], total+1}
        fish > 0 -> 
          {[fish-1 | next], total}
    end
    |> IO.inspect()
    start(next, days-1, total)
  end

  def old_start(init, days) do
    {init, new} = init 
    |> Enum.reduce({[],[]}, fn fish, {init, new} -> 
      {init, new} = cond do
        fish == 0 -> 
          {[6|init], [8|new]}
        fish > 0 -> 
          {[fish-1|init], new}
      end
      {init, new}
    end)
    start(Enum.reverse(init) ++ Enum.reverse(new), days-1)
  end

  def exec(init, days) when is_list(init) do
    init = init
    # |> IO.inspect()
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
    start(init, days)
  end

  def exec(init, days) do
    exec(init|> String.split(",", trim: true), days)
  end

  def exec(days), do: exec(parse_input(), days)

  def exec(), do: parse_input()

  def cal(days, sum\\0)

  def cal(days, _sum) do
    # days |> IO.inspect(label: "days")
    total = div(days, 7)
            # |> IO.inspect(label: "total")
    child_total = if total > 1 do
      1..total
      |> Enum.to_list()
      # |> IO.inspect(charlists: :list)
      |> Enum.map(&(days - &1*7 - 2))
      |> Enum.filter(&(&1>=7))
      # |> IO.inspect(charlists: :list)
      |> Enum.map(&(cal(&1)))
      # |> IO.inspect(label: "SHOW", charlists: :list)
      |> List.flatten()
      |> Enum.sum()
    else
      0
    end
    total + child_total
  end

  def cal_day(state, days) do
    cal(days+5-(state-1))+1
  end

  def cal_total(states, days) do
    IO.inspect(states)
    parse_input()
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
    |> Enum.map(&(cal_day(&1, days)))
    |> Enum.sum()
  end
end

Advent.Day.exec("3,4,3,1,2", 18) 
|> IO.inspect()
|> length()
|> IO.inspect(charlists: :list)

# Advent.Day.cal_day(3, 25)
Advent.Day.cal_total([3,4,3,1,2], 18) 
|> IO.inspect(charlists: :list)
