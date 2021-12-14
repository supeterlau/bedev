defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    {rules, [template]} = 
      parse_input()
      |> Enum.split_with(fn line -> 
        String.contains?(line, "->") 
      end)
    init = %{template|>String.at(-1) => 1}
    template = 
      (0..String.length(template)-2) 
      |> Enum.map(fn idx -> 
        String.at(template, idx) <> String.at(template, idx+1)
      end) 
      |> Enum.group_by(&(&1)) 
      |> Enum.map(fn {k,v} ->
        {k, length(v)} 
      end) 
      |> Enum.into(%{})
    
    rules = rules
    |> Enum.map(&String.split(&1, " -> "))
    |> Enum.map(fn [lh, rh] -> {lh, rh} end)
    |> Enum.into(%{})

    step(template, rules, 40)
    # |> count()
    # count + 1
    |> count_chars(init)
    |> Map.to_list()
    |> Enum.sort(fn {_, c1}, {_, c2} -> c1 > c2 end)
    |> cal()
    # |> Map.values() |> Enum.sum()
  end

  def step(template, _, 0) do
    template
  end

  def step(template, rules, n) do
    template = template
    |> Enum.reduce(%{}, fn {pair, times}, new_template -> 
      insert(new_template, rules, pair, times)
    end)
    step(template, rules, n-1)
  end

  def insert(template, rules, pair, times) do
    new = Map.fetch!(rules, pair)
    [first, last] = pair |> String.split("", trim: true)
    %{first<>new => times, new<>last => times}
    |> Enum.reduce(template, fn {pair, v}, new_template -> 
      new_template
      |> Map.update(pair, v, fn value -> value + v end)
    end)
  end

  def count_chars(result, init) do
    result
    |> Enum.reduce(init, fn {pair, count}, chars -> 
      char = pair
      |> String.split("", trim: true)
      |> hd()
      chars
      |> Map.update(char, count, fn old -> old + count end)

      # |> Enum.reduce(chars, fn char, new_chars -> 
      #   new_chars
      #   |> Map.update(char, count, fn old -> old + count end)
      # end)
    end)
  end

  def count(result) do
    result
    |> Map.values()
    |> Enum.sum()
  end

  def cal(chars) do
    {_, first} = List.first(chars)
    {_, last} = List.last(chars)
    first - last
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
