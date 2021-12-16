defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input2.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input3.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input4.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    parse_input()
    |> hd()
    # "D2FE28B8006F45291200EE00D40C823060"
    |> hex_to_bin()
    |> padding()
    |> parse(%{}, [])
    |> sum_versions()
  end

  def padding(bin) do
    length = String.length(bin)
    case rem(length, 4) do
      0 -> bin
      _ -> 
        pad = (div(length, 4) + 1) * 4
        String.pad_leading(bin, pad, "0")
    end
  end

  # [%{version: 7, type_id: 3, length_type_id: 1, subpacks_length: 3, subpacks: []}]
  def parse(bin, pack, packs, drop_zero \\ true, time \\ nil)

  def parse(tail, _, packs, _, 0) do
    {packs, tail}
  end

  def parse("", _, packs, _, _) do
    packs
  end

  def parse(bin, pack, packs, drop_zero, time) do
    packs
    |> IO.inspect(charlists: :list, label: "packs")
    bin
    |> IO.inspect(charlists: :list, label: "parse")
    [version, tail] = take(bin, 3)
    [type_id, tail] = take(tail, 3)
    pack = Map.merge(pack, %{version: bin_to_dec(version), type_id: bin_to_dec(type_id)})
    case type_id do
      "100" ->
        parse_literal(tail, pack, packs, drop_zero, time)
      _type_id ->
        parse_operator(tail, pack, packs, drop_zero, time)
    end
  end

  def parse_literal(bin, pack, packs, drop_zero \\ true, time \\ nil) do
    bin
    |> IO.inspect(charlists: :list, label: "parse_literal")
    [number_part, tail] = take(bin, 5)
    value_part = String.slice(number_part, 1, 4)
    pack = pack
    |> Map.update(:number, [value_part], fn value -> [value_part | value] end)
    if String.starts_with?(number_part, "1") do
      parse_literal(tail, pack, packs)
    else
      # drop 3
      # tail = drop(tail, 3)
      pack = pack 
             |> Map.update(:number, [], fn value -> 
               Enum.reverse(value)
               |> Enum.join()
               |> bin_to_dec()
             end)
      tail = if drop_zero, do: drop0(tail), else: tail
      case time do 
        nil -> parse(tail, %{}, [pack | packs], drop_zero)
        0 -> parse(tail, %{}, [pack | packs], drop_zero, 0)
        time -> parse(tail, %{}, [pack | packs], drop_zero, time-1)
      end
    end
  end

  def parse_operator(bin, pack, packs, drop_zero \\ true, time \\ nil) do
    bin
    |> IO.inspect(charlists: :list, label: "parse_operator")
    [length_type_id, tail] = take(bin, 1)
    {pack, tail} = case length_type_id do
      "0" ->
        [pack_length, tail] = take(tail, 15)
        pack_length = bin_to_dec(pack_length)
                      |> IO.inspect(label: "pack_length")
        [literal, tail] = take(tail, pack_length)
        values = parse(literal, %{}, [], false)
                 |> Enum.reverse()
        {pack |> Map.merge(%{
          length_type_id: bin_to_dec(length_type_id),
          pack_length: pack_length,
          operators: values
        }), tail}
      "1" ->
        [count, tail] = take(tail, 11)
        count = bin_to_dec(count)
                |> IO.inspect(label: "count")
        {ops, tail} = parse(tail, %{}, [], false, count)
        {pack |> Map.merge(%{
          length_type_id: bin_to_dec(length_type_id),
          operators_count: count,
          operators: ops
        }), tail}
      "" -> {packs, tail}
    end
    tail = if drop_zero, do: drop0(tail), else: tail
    case time do 
      nil -> parse(tail, %{}, [pack | packs], drop_zero)
      0 -> parse(tail, %{}, [pack | packs], drop_zero, 0)
      time -> parse(tail, %{}, [pack | packs], drop_zero, time-1)
    end
  end

  # def parse_count(bin, pack, packs, 0) do
  #   {packs, bin}
  # end

  # def parse_count(bin, pack, packs, count) do
  #   parse(bin, pack, packs)
  # end

  def sum_versions(packs) do
    find_versions(packs, [])
    |> Enum.sum()
  end
  
  def find_versions(packs, versions) do
    pack_versions = packs |> Enum.map(&Map.fetch!(&1, :version))
    operators = packs |> Enum.map(&Map.get(&1, :operators)) |> List.flatten()
                |> Enum.reject(&is_nil(&1))
    versions = pack_versions ++ versions
    if operators == [] do
      versions
    else
      find_versions(operators, versions)
    end
  end

  def split_by(bin, n) do
    String.split(bin, ~r/.{#{n}}/, trim: true, include_captures: true)
  end

  def take(bin, n) do
    case String.split(
      bin, ~r/^[01]{#{n}}/, 
      trim: true, include_captures: true) do
      [head, tail] -> [head, tail]
      [head] -> [head, ""]
      [] -> ["",""]
    end
  end

  def drop(bin, n) do
    String.slice(bin, n..-1)
  end

  def drop0(bin) do
    if String.starts_with?(bin, "0") do
      bin
      |> drop(1)
      |> drop0()
    else
      bin
    end
  end

  def bin_to_dec(bin) when is_binary(bin), do: String.to_integer(bin, 2)

  def hex_to_bin(hex) when is_binary(hex) do
    String.to_integer(hex, 16)
    |> Integer.to_string(2)
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
