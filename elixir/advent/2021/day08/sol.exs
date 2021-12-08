defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{[^|]\n}, trim: true, include_captures: true)
    File.read!('./input.txt') 
    |> String.replace(~r{\|\n}, "| ")
    |> String.split(~r{\n}, trim: true)
  end

  def digit_map() do
    Enum.zip(
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
      [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]
    )
  end

  def parse_digits_1(line) do
    [left, right] = line
    |> String.split(~r{ \|[\n ]}, trim: true)
    left
    |> String.split(~r{ }, trim: true)
    |> Enum.map(fn signal -> 
      {signal, String.length(signal)}
    end)
    |> Enum.into(%{})
  end

  def parse_right(line) do
    line
    |> String.split(~r{ \|[\n ]}, trim: true)
    |> Enum.at(1)
|> IO.inspect(charlists: :list)
    |> String.split(~r{ }, trim: true)
    |> Enum.map(&(String.length(&1)))
  end

  def exec1() do
    uniq_numbers = [1, 7, 4, 8]
    uniq_number_patterns = [2, 3, 4, 7]
    parse_input()
    |> Enum.map(&(parse_right(&1)))
    |> Enum.map(fn list ->
      list
      |> Enum.filter(&(&1 in uniq_number_patterns))
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  def count_match(test, target) do
    target
    |> Enum.filter(&(&1 in test))
    |> Enum.count()
  end

  # def exec2() do
  #   uniq_map = %{
  #     7 => "dab",
  #     1 => "ab",
  #     8 => "acedgfb",
  #     4 => "eafb"
  #   } |> Enum.map(fn {k,v}->{k, v|>String.split("")} end)
  #   |> Enum.into(%{})
  #   uniq_numbers = [1, 7, 4, 8]
  #   uniq_number_patterns = [2, 3, 4, 7]
  #   uniq_map = Enum.zip(uniq_number_patterns, uniq_numbers)
  #   [patterns, remain] = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab"
  #   |> String.split(~r{ }, trim: true)
  #   |> Enum.filter(&(String.length(&1) in uniq_number_patterns))
  #   patterns
  #   |> Enum.map(fn pattern ->
  #     {uniq_map[String.length(pattern)], pattern}
  #   end)
  #   |> Enum.into(%{})

  #   [digit5, digit6] = remain 
  #                      |> Enum.group_by(&(String.length()))

  #   # eight_map = %{
  #   # }
  #   # one = 0
  #   # 1 -> 6
  #   # 1 -> 3
  #   # 1+6 -> 5 / 2
  #   # 5 -> 9

  # end

  def exec() do
    parse_input()
    |> Enum.map(&(parse_digits(&1)))
    |> IO.inspect(charlists: :list)
    |> Enum.sum()
  end

  def sort_str(str) do
    str |> String.split("", trim: true) |> Enum.sort() |> Enum.join()
  end

  def is_match(str1, str2) do
    sort_str(str1) == sort_str(str2)
  end

  def parse_digits(line) do
    [left, right] = line
    |> String.split(~r{ \|[\n ]}, trim: true)
    # left = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab" 
    # right = "cdfeb fcadb cdfeb cdbaf"
    pattern_map = left
    |> String.split(" ")
    |> Enum.map(fn elem -> {elem, String.length(elem)} end) 
    |> Enum.into(%{})
    uniq_numbers = [1, 7, 4, 8]
    uniq_number_patterns = [2, 3, 4, 7]
    uniq_map = Enum.zip(uniq_number_patterns, uniq_numbers) |> Enum.into(%{})
    pattern_map = pattern_map
    |> Enum.map(fn {k, v} -> 
      {k, uniq_map[v]}
    end) |> Enum.into(%{})
    uniq_patterns = pattern_map 
                    |> Enum.filter(fn {_, v} -> not is_nil(v) end) 
                    |> Enum.map(fn {k, v} -> {v, k|>String.split("", trim: true)} end)
                    |> Enum.into(%{})
    remain = pattern_map |> Enum.filter(fn {_,v} -> is_nil(v) end) |> Enum.map(fn {k, _} -> k end) |> Enum.group_by(&String.length(&1))
    pattern1 = uniq_patterns[1]
    pattern4 = uniq_patterns[4]
    pattern_map = pattern_map 
    |> Map.merge(parse5(remain[5], pattern1, pattern4))
    |> Map.merge(parse6(remain[6], pattern1, pattern4))
    |> Enum.map(fn {k, v} -> {sort_str(k), v} end)
    |> Enum.into(%{})

    four_digits = right
                  |> String.split(" ", trim: true)
                  |> Enum.map(&(sort_str(&1)))
                  |> Enum.map(&(pattern_map[&1] |> Integer.to_string()))
                  |> Enum.join()
                  |> Integer.parse()
                  |> elem(0)
  end

  def parse5(remain, pattern1, pattern4) do
    remain 
    |> Enum.map(&String.split(&1, "", trim: true)) 
    |> Enum.map(fn test -> 
      test_str = test |> Enum.join()
      cond do
        count_match(test, pattern4) == 2 ->
          {test_str, 2}
        count_match(test, pattern1) == 2 ->
          {test_str, 3}
        true ->
          {test_str, 5}
      end
    end)
    |> Enum.into(%{})
  end

  def parse6(remain, pattern1, pattern4) do
    remain 
    |> Enum.map(&String.split(&1, "", trim: true)) 
    |> Enum.map(fn test -> 
      test_str = test |> Enum.join()
      cond do
        count_match(test, pattern4) == 4 ->
          {test_str, 9}
        count_match(test, pattern1) == 1 ->
          {test_str, 6}
        true ->
          {test_str, 0}
      end
    end)
    |> Enum.into(%{})
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
