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
    # "EE00D40C823060"
    # "9C0141080250320F1802104A08"
    # "D8005AC2A8F0"
    # "880086C3E88112"
    # "C200B40A82"
    # "CE00C43D881120"
    # "04005AC33890"
    # "38006F45291200"
    |> hex_to_bin()
    # |> sum_versions()
    |> parse_packs()
    |> cal()
  end

  def pad_parse(bin, n \\ 1) do
    bin
    |> padding(n)
    |> parse(%{}, [])
    |> elem(0)
  end

  def parse_packs(bin, n \\ 1) do
    packs = pad_parse(bin, n) |> hd()
    ops = Map.get(packs, :operators)
    if ops != [] and check_operators(ops) do
      packs
    else
      parse_packs(bin, n+1)
    end
  end

  def check_operators([]), do:  true

  def check_operators(ops) do
    [head | tail] = ops
    new_ops = Map.get(head, :operators, [])
    if Map.has_key?(head, :operators) and new_ops == [] do
      false
    else
      new_ops = new_ops |> Enum.reject(fn %{type_id: type} -> type == 4 end)
      check_operators(new_ops ++ tail)
    end
  end

  def cal(0, values), do: Enum.sum(values)
  def cal(1, values), do: Enum.reduce(values, 1, fn value, acc -> value*acc end)
  def cal(2, values), do: Enum.min(values)
  def cal(3, values), do: Enum.max(values)
  def cal(5, [f, s]), do: if f > s, do: 1, else: 0
  def cal(6, [f, s]), do: if f < s, do: 1, else: 0
  def cal(7, [f, s]), do: if f == s, do: 1, else: 0

  def cal(%{number: value, type_id: 4}), do: value

  def cal(%{operators: ops, type_id: type}) do
    values = ops |> Enum.map(&cal(&1))
    cal(type, values)
  end

  def padding(bin, n) do
    length = String.length(bin)
    case rem(length, 4) do
      0 -> bin
      _ -> 
        pad = (div(length, 4) + n) * 4
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
