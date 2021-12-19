defmodule Advent.Day do

  def log(item, label) do
    IO.inspect(item, charlists: :list, label: label)
  end

  def log(item) do
    IO.inspect(item, charlists: :list)
  end
   
  def parse_input() do
     File.read!('./input1.txt') |> String.split(~r{---.*---}, trim: true)
     # File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    beacons = parse_input()
    |> Enum.map(fn scan -> 
      scan
      |> String.split(~r{\n}, trim: true)
      |> Enum.map(&"{#{&1}}"|>Code.eval_string()|>elem(0))
    end)
    [s0 | rest] = 0..length(beacons)-1
                 |> Enum.map(&{&1, Enum.at(beacons, &1)|>dist()})
    rest_map = rest |> Enum.into(%{})
    resolve(s0, rest_map, %{}, 0, rest)
  end

  def sub(p1,p2) do
    0..tuple_size(p1)-1
    |>Enum.map(&(elem(p1, &1)-elem(p2, &1)))
    |> List.to_tuple()
  end
  
  def resolve(result, zps) do
    fkey_map = zps 
               |> Enum.map(fn {k, v} ->
                 Map.keys(v) |> Enum.map(&{&1, k}) 
               end)
               |> List.flatten()
               |> Enum.into(%{})
    result = result |> Enum.reduce(%{}, fn {k, v}, new_ps -> 
      fkeys = new_ps |> Enum.map(fn {k, v} -> k end)
      cond do
        k == 0 -> Map.merge(new_ps, %{k => v})
        true ->
          up_key = fkey_map |> Map.get(k)
          cv = v
          |> Enum.map(fn {vk, {vv, _}} -> 
            {kv, pat} = Map.get(zps, up_key) |> Map.get(k)
            # {vk, {convert(vv, pat), nil}}
            {vk, {sub(kv, convert(vv, pat)), nil}}
          end)
          |> Enum.into(%{})
          Map.update(new_ps, up_key, cv, fn old -> Map.merge(old, cv) end)
      end
    end)
    if length(Map.keys(result)) == 1 do
      result
    else
      # resolve(result, zps)
      result
    end
  end

  def resolve(_, [], zps, _, _), do: zps

  def resolve({k, s0}, tail, zps, zp, rest) do
    if k in Map.keys(tail) do
      [{zp, _}=head | rest] = rest
      resolve(head, tail, zps, zp, rest)
    else
      {fail, ps} = tail
                   |> Enum.map(fn {k, v} -> {k, find_s(s0, v)} end)
                   |> Enum.split_with(fn {_, v} -> v == {} end)
      zps = Map.put(zps, zp, ps|>Enum.into(%{}))
      if fail == [] do
        resolve(zps, zps)
      else
        fail_keys = fail|>Enum.map(fn {k,_} -> k end)
        tail = Map.take(tail, fail_keys)
        [{zp, _}=head | rest] = rest
        resolve(head, tail, zps, zp, rest)
      end
    end
  end

  def find_s(s0, s1) do
    vs0 = Map.values(s0)
          |> Enum.sort()
    vs1 = Map.values(s1)
          |> Enum.sort()
    vs = (vs0 ++ vs1)
           |> Enum.group_by(&(&1))
           |> Enum.reject(fn {k,v}->length(v)==1 end)
           |> Enum.map(fn {k, _}->k end)
    share0 = findp(s0, vs)
    share1 = findp(s1, vs)
    share0
    |> Enum.map(fn {k, v} -> {v, Map.get(share1, k)} end)
    |> Enum.take(2)
    |> cal_all()
    |> log(:call_all)
  end

  def cal_all(pairs) do
    result = pairs
    |> Enum.reduce(%{}, fn {p0, p1}, ps -> 
      new_ps = for p <- all(p1) do
        {cal({p0, p}), {p, p1}}
      end |> List.flatten()
      |> Enum.into(%{})
      if ps == %{} do
        new_ps
      else
        keys = Map.keys(ps)
        new_ps
        |> Enum.filter(fn {k,_} -> k in keys end)
        |> Enum.into(%{})
      end
    end)
    |> Enum.map(fn {k, {p, p0}} -> {k, find_pat(p, p0)} end)
    if length(result) == 1 do
      result |> hd()
    else
      {}
    end
  end

  def value_map(p) do
    p = p |> Tuple.to_list()
    np = p |> Enum.map(&(-&1))
    Enum.zip(
      [:x,:y,:z,:nx,:ny,:nz],
      p++np
    )
    |> Enum.into(%{})
  end

  def convert(p, pat) do
    values = value_map(p)
             |> log(:convert)
    pat
             |> log(:convert)
    |> Enum.map(fn p -> Map.get(values, p) end)
             |> log(:convert)
    |> List.to_tuple()
  end

  def pat_map(p) do
    p = p |> Tuple.to_list()
    np = p |> Enum.map(&(-&1))
    Enum.zip(
      p++np,
      [:x,:y,:z,:nx,:ny,:nz]
    )
    |> Enum.into(%{})
  end

  def find_pat(p, p0) when is_tuple(p0) do
    pats = pat_map(p0)
           |>log()
    find_pat(p, pats)
  end

  def find_pat(p, pats) when is_map(pats) do
    p
    |> Tuple.to_list()
    |> Enum.map(&pats|>Map.get(&1))
  end

  def cal({p0, p1}) do
    0..tuple_size(p0)-1
    |> Enum.map(&(elem(p0, &1)+elem(p1, &1)))
    |> List.to_tuple()
  end

  def all({x, y, z}) do
    values = [x,y,z]
    values = (values |> Enum.map(&(-&1))) ++ values
    for m <- values do
      for n <- values, abs(n) != abs(m) do
        for p <- values, abs(p) != abs(n) and abs(p) != abs(m)  do
          {m, n, p}
        end
      end
    end
    |> List.flatten()
  end

  def getloc(b1, b2) do
    Enum.zip(b1, b2)
    |> Enum.map(fn {p1, p2} -> 
      0..2
      |> Enum.map(&(elem(p1, &1)-elem(p2, &1)))
    end)
  end

  def findp(beacons, values) do
    beacons
    |> Enum.filter(fn {_, v} -> v in values end)
    |> Enum.map(fn {{p1, p2}, v}->[{p1, v}, {p2, v}] end)
    |> List.flatten()
    |> Enum.group_by(fn {k, _} -> k end)
    |> Enum.map(fn {k, v} -> 
      v = v
      |> Enum.map(fn {_,v} -> v end)
      |> Enum.sort()
      |> List.to_tuple()
      {v, k}
    end)
    |> Enum.into(%{})
  end

  def dist(beacons) do
    total = length(beacons)
    for b1 <- 0..total-2 do
      for b2 <- b1+1..total-1 do
        p1 = Enum.at(beacons,b1)
        p2 = Enum.at(beacons,b2)
        {{p1, p2}, cal_dist(p1, p2)}
      end
    end
    |> List.flatten()
    |> Enum.into(%{})
  end

  def cal_dist(b1, b2) do
    0..2
    |> Enum.map(&(elem(b1, &1)-elem(b2, &1)))
    |> Enum.map(&:math.pow(&1,2))
    |> Enum.sum()
    # |> :math.sqrt()
  end

  def normalize(scanner, beacon) do
  end
end

# Advent.Day.normalize()
Advent.Day.exec()
|> Advent.Day.log()
# pat = {-355, 545, -477}
# |> Advent.Day.pat_map()
# 
# {-355, -545, -477}
# |> Advent.Day.find_pat(pat)
# |> Advent.Day.log()

