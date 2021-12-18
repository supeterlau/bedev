defmodule Advent.Day do
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def value_list(elem) do
    elem
    |> String.split("", trim: true) 
    |> Enum.map(&(Integer.parse(&1)|>elem(0)))
  end

  def count_bits(data, init) do
    data 
    |> Enum.reduce(init, fn elem, acc ->
      with current <- value_list(elem) do
        Enum.zip([acc,current]) |> Enum.map(fn {a, b} -> a+b end)
      end
    end)
  end

  def p1() do
    data = parse_input()
    count = hd(data)|>String.length()
    len = length(data) |> IO.inspect()
    init = List.duplicate(0,count)
    op = List.duplicate("1",count) |> Enum.join() |> Integer.parse(2) |> elem(0)
    gamma = count_bits(data, init)
            |> Enum.map(&(if &1 * 2 > len, do: "1", else: "0"))
            # |> Enum.map(&(Integer.to_string(&1)))
            |> Enum.join()
            |> Integer.parse(2)
            |> elem(0)
    gamma * (Bitwise.bxor(gamma, op))
    |> IO.inspect()
  end

  def find_rate(data, init, gt, lt, equal_value, acc \\ [])

  def find_rate([""], _, _, _, _, acc) do
    acc |> Enum.reverse()
  end
  
  def find_rate(data, _, _, _, _, acc) when length(data) == 1 do
    (acc |> Enum.reverse()) ++ (hd(data) |> String.split("", trim: true))
  end

  def find_rate(data, init, gt, lt, equal_value, acc) do
    len = length(data) # |> IO.inspect()
    count = count_bits(data, init) 
    [head | _] = count
    filter = cond do
      head * 2 > len ->
        # "1"
        gt
      head * 2 < len ->
        # "0"
        lt
      head * 2 == len ->
        equal_value
     end
    acc = [filter | acc]
    data = data 
      |> Enum.filter(&(String.starts_with?(&1, filter))) 
      |> Enum.uniq()
      |> Enum.map(fn <<_::utf8>> <> tail -> tail end)
    find_rate(data, init, gt, lt, equal_value, acc)
  end

  def find_oxygen(data, init) do
    find_rate(data, init, "1", "0", "1")
  end
    
  def find_CO2(data, init) do
    find_rate(data, init, "0", "1", "0")
  end

  def bits_to_decimal(bits) do
    bits |> Enum.join() |> Integer.parse(2) |> elem(0)
  end

  def exec() do
    # life support rating <- oxygen generator rating * CO2 scrubber rating
    data = parse_input()
    count = hd(data)|>String.length()
    # len = length(data)
    init = List.duplicate(0,count)
    oxygen_rate = find_oxygen(data, init) |> bits_to_decimal()
    co2_rate = find_CO2(data, init) |> bits_to_decimal()
    oxygen_rate * co2_rate |>IO.inspect()
  end
end

Advent.Day.exec()
