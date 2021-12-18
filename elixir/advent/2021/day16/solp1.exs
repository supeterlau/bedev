defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input2.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input3.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input4.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    parse_input()
    |> hd()
    |> hex_to_bin()
    |> padding()
    |> parse(%{}, [])
    |> elem(0)
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
  def parse(t \\ :prepare, bin, pack, packs, time \\ nil, opts \\ [drop_zero: true])

  def parse(_, "", _, packs, _, _) do
    {packs, ""}
  end

  def parse(_, tail, _, packs, 0, _) do
    {packs, tail}
  end

  def parse(:prepare, bin, pack, packs, time, opts) do
    [version, tail] = take(bin, 3)
    [type_id, tail] = take(tail, 3)
    pack = Map.merge(pack, %{version: bin_to_dec(version), type_id: bin_to_dec(type_id)})
    {packs, tail} = case type_id do
      "100" ->
        parse(:literal, tail, pack, packs, nil, opts)
      _type_id ->
        parse(:operator, tail, pack, packs, nil, opts)
    end
    [drop_zero: drop_zero] = opts 
    tail = if drop_zero, do: drop0(tail), else: tail
    case time do 
      nil -> parse(:prepare, tail, %{}, packs, nil, opts)
      time -> 
        parse(:prepare, tail, %{}, packs, time-1, opts)
    end
  end

  def parse(:literal, bin, pack, packs, _, opts) do
    [number_part, tail] = take(bin, 5)
    value_part = String.slice(number_part, 1, 4)
    pack = pack
    |> Map.update(:number, [value_part], fn value -> [value_part | value] end)
    if String.starts_with?(number_part, "1") do
      parse(:literal, tail, pack, packs, nil, opts)
    else
      pack = pack 
             |> Map.update(:number, [], fn value -> 
               Enum.reverse(value)
               |> Enum.join()
               |> bin_to_dec()
             end)
      {[pack|packs], tail}
    end
  end

  def parse(:operator, bin, pack, packs, _, opts) do
    [length_type_id, tail] = take(bin, 1)
    {pack, tail} = case length_type_id do
      "0" ->
        [pack_length, tail] = take(tail, 15)
        pack_length = bin_to_dec(pack_length)
        [literal, tail] = take(tail, pack_length)
        opts = opts |> Keyword.replace(:drop_zero, false)
        {ops, _} = parse(:prepare, literal, %{}, [], nil, opts)
        {pack |> Map.merge(%{
          length_type_id: bin_to_dec(length_type_id),
          pack_length: pack_length,
          operators: ops |> Enum.reverse()
        }), tail}
      "1" ->
        [count, tail] = take(tail, 11)
        count = bin_to_dec(count)
        opts = opts |> Keyword.replace(:drop_zero, false)
        {ops, tail} = parse(:prepare, tail, %{}, [], count, opts)
        {pack |> Map.merge(%{
          length_type_id: bin_to_dec(length_type_id),
          operators_count: count,
          operators: ops |> Enum.reverse()
        }), tail}
    end
    {[pack | packs], tail}
  end

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
