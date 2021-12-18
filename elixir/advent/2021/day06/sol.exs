defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n|,}, trim: true)
  end

  def exec(states, days) do
    start(states, days)
  end

  def exec(days) do
    states = parse_input()
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
    exec(states, days)
  end

  def start(_states, 0, total) do
    total
  end

  def start(states, 0) do
    states
  end

  def start(states, days) do

    container = Enum.zip(0..8|>Enum.to_list(), List.duplicate(0,8)) |> Map.new()
    states = states
    |> Enum.group_by(fn v -> v end) |> Enum.map(fn {k,v} -> {k, length(v)} end) |> Enum.into(%{})
    Map.merge(container, states)
    |> start_day(days)
  end

  def start_day(states, 0) do
    states
    |> Map.values() |> Enum.sum()
  end

  def start_day(states, days) do
    {old_7, states }= Map.pop(states, 7, 0)
    new_8 = Map.get(states, 0, 0)
    states = states
    |> Enum.map(fn {state, count}-> 
       cond do
         state == 0 ->
           {6, count}
         true ->
           {state - 1, count}
       end
     end)
     |> Enum.into(%{})
    # states |> IO.inspect()
    Map.update(states, 6, 0, fn value -> value + old_7 end)
    |> Map.put(8, new_8)
    |> start_day(days-1)
  end

  def start0(states, days) do
    {init, new} = states
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

  def count_child(state, days) do
    total = div(days+5-(state-1), 7)
    n = div(days-2-7, 7)
    div((2*days-7*n-11)*n, 14) + total + 1
  end
end

# Advent.Day.count_child(8, 18)
# |> IO.inspect(charlists: :list)

# Advent.Day.exec([5,5,5,5,5], 18) 
# Advent.Day.exec([3,4,3,1,2], 18) 
# |> IO.inspect(charlists: :list)
# []
# |> length()
# |> IO.inspect(charlists: :list)

Advent.Day.exec(256)
|> IO.inspect(charlists: :list)
# 
# Advent.Day.exec([3,4,3,1,2], 256) 
# |> IO.inspect(charlists: :list)
