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
    # |> IO.inspect()
    |> Enum.map(&(Integer.parse(&1) |> elem(0)))
    start(init, days)
  end

  def exec(init, days) do
    exec(init|> String.split(",", trim: true), days)
  end

  def exec(days), do: exec(parse_input(), days)

  def exec(), do: parse_input()

  def cal(days, sum \\ 0, idx \\ 0, last \\ 0)

  def cal(days, _, _, _) when days <= 0, do: 0

  def cal(_days, sum, idx, last) when idx >= last and idx != 0 do
    sum
  end

  def cal1(days, sum, idx, last) do
    {days, sum, idx, last} |> IO.inspect(label: "days")
    child_days = if idx == 0, do: days, else: days - 2 - idx * 7
    total = div(child_days, 7)
            |>IO.inspect()
    total = if total > 1 and idx > 0 do
      total |> IO.inspect(label: "total")
      days = days - 2 - idx * 7
            |> IO.inspect()
      cal(days, 0, 1, total) + total
    else
      total
    end
    last = if idx == 0, do: total, else: last
    cal(days, sum+total, idx+1, last)
  end
  
  def cal_child(days, outer_sum, outer_idx, inner_count \\ 0, innser_sum \\ 0, inner_idx \\ 0)

  def cal_child(days, outer_sum, outer_idx, inner_count, innser_sum, inner_idx) when inner_count <=1 do
    outer_sum
  end

  def cal_child(days, outer_sum, outer_idx, inner_count, innser_sum, inner_idx) do
    {days, outer_sum, outer_idx} |> IO.inspect()
    child_days = days - 8 - 2 - inner_idx * 7
      |> IO.inspect(label: "child days")
    total = div(child_days, 7)
      |> IO.inspect(label: "child total")
    if total > 1 do
      cal_child(days, outer_sum, outer_idx)
        |> IO.inspect(label: "child total")
    else
      total + outer_sum
    end
  end

  def cal(days, sum, idx, last) do
    total = div(days, 7)
            |> IO.inspect(label: "out total")

  end

  def cal_day(state, days) do
    cal(days+7-state)+1
  end

  def cal_list(states, days) do
    states
    |> Enum.map(fn state -> 
      cal_day(state, days)
    end)
    |> Enum.sum()
  end
end

# Advent.Day.cal(42)
# Advent.Day.cal(49)

Advent.Day.exec("3", 20) 
|> IO.inspect()
|> length()
|> IO.inspect()

Advent.Day.cal_day(3, 20)
|> IO.inspect()

# |> IO.inspect(charlists: :list)

