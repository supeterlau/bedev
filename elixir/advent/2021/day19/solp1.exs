defmodule Advent.Day do

  def log(item, label) do
    IO.inspect(item, charlists: :list, label: label)
  end

  def log(item) do
    IO.inspect(item, charlists: :list)
  end
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{---.*---}, trim: true)
     File.read!('./input2.txt') |> String.split(~r{---.*---}, trim: true)
  end

  def exec() do
    pbeacons = parse_input()
    |> Enum.map(fn scan -> 
      scan
      |> String.split(~r{\n}, trim: true)
      |> Enum.map(&"{#{&1}}"|>Code.eval_string()|>elem(0))
    end)
    # [s0 | rest] = 0..length(beacons)-1
    beacons = 0..length(pbeacons)-1
                 |> Enum.map(&{&1, Enum.at(pbeacons, &1)|>dist()})
    # rest_map = rest |> Enum.into(%{})
    # zps = resolve(s0, rest_map, %{}, 0, rest, rest)
    zps = resolv(beacons)
    # fix_values(beacons|>Enum.with_index(), zps)
    # resolv_zps([], 0..length(beacons)-1, [], zps, 0)
    # |> tranverse()
    path = resolv_zps(zps, 0, %{}, [0], 0..length(beacons)-1)
    |> Map.values()
    [next | path] = path
    zps = tranverse(path, next, zps, [])
    fix_values(pbeacons|>Enum.with_index(), zps)
  end

  def tranverse([], next, zps, lists) do
    # limits = lists
    # |> Enum.group_by(fn {k, v}->k end)
    # |> Enum.map(fn {k, v}-> {k, v |> Enum.map(fn {k,v}-> v end)} end)

    zps
    |> Enum.filter(fn {k, v} -> 
      {k, v |> Map.keys() |> hd()} in lists
    end)
    |> Enum.group_by(fn {k, _} -> k end)
    |> Enum.map(fn {k, v} -> 
      {k, v |> Enum.reduce(%{}, fn {_, vv}, pm -> 
        Map.merge(pm, vv)
      end)}
    end)
    |> Enum.into(%{})
    |> log(:zps)
  end

  def tranverse(path, next, zps, lists) do
    [head | tail] = path
    paths = next
    |> Enum.map(fn v -> 
      for n1 <- head do
        for n2 <- get_next(v, zps), n1==n2 do
          {v, n1}
        end
      end
    end)|>List.flatten()|> Enum.filter(&(&1 != []))
    lists = paths ++ lists
    tranverse(tail, head, zps, lists)
  end


  def resolv(scanners) do
    for {k1, s1} <- scanners do
      for {k2, s2} <- scanners, s1 != s2 do
        value = find_s(s1, s2)
        if value != {} do
          {k1, %{k2 => value}}
        else 
          {}
        end
      end |> Enum.filter(&(&1!={}))
    end
    |> List.flatten()
    # |> Enum.filter(&(length(&1)>1))
    # |> Enum.map(fn {k, v} -> {{k, Map.keys(v)|>hd()}, v} end)
    |> log(:resolv)
  end

  def get_next(key, zps) do
    zps
    |> Enum.filter(fn {k,_}->k==key end)
    |> Enum.map(fn {_, v} -> v|>Map.keys()|>hd() end)
  end

  def resolv_zps(result, scanners, to_check, zps, next \\ 0)

  def resolv_zps(result, [], _, zps, _) do
    result |> log(:result)
    zps
  end

  def resolv_zps(zps, lvl, lvl_map, next, scanners) do
    scanners = scanners |> Enum.reject(&(&1 in next))
              |>log(:lvl_map)
    lvl_map = Map.put(lvl_map, lvl, next)
              |>log(:lvl_map)
    if scanners != [] do
      nps = next |> Enum.map(&(get_next(&1, zps))) 
              |>log(:lvl_map)
            |> List.flatten()
            |> Enum.uniq()
            |> Enum.filter(&(&1 in scanners))
              |>log(:lvl_map)
      if nps == [] do
        lvl_map
      else
        resolv_zps(zps, lvl+1, lvl_map, nps, scanners)
      end
    else
      lvl_map
    end
  end

  def resolv_zps(result, scanners, to_check, zps, next) do
    scanners = scanners |> Enum.reject(&(&1 == next))
    nps = get_next(next, zps) |> Enum.filter(&(&1 in scanners))
    if nps == [] do
      result
      |>log(:result)
      if length(result) < 24 do
        head = hd(to_check)
        [more | result] = result
        scanners = [more | scanners]
        if is_list(head) do
          [head | htail] = head
          to_check = if htail != [], do: htail++to_check, else: to_check
          resolv_zps(result, scanners, to_check, zps, head)
        else
          resolv_zps(result, scanners, to_check, zps, head)
        end
      end
    else
      [head | tail] = nps
      scanners = scanners |> Enum.reject(&(&1 == head))
      to_check = tail ++ to_check
      result = [head | result]
      resolv_zps(result, scanners, to_check, zps, head)
    end

    # else
    #   nps 
    #   |> Enum.map(fn n -> 
    #     scanners = scanners |> Enum.reject(&(&1 in [next, n]))
    #     result = [{next, n} | result]
    #     resolv_zps(result, scanners, zps, n)
    #   end)
    # end
  end

  def sub(p1,p2) do
    0..tuple_size(p1)-1
    |>Enum.map(&(elem(p1, &1)-elem(p2, &1)))
    |> List.to_tuple()
  end

  def fix_values(rest, zps) do
    fkey_map = zps 
               |> Enum.map(fn {k, v} ->
                 Map.keys(v) |> Enum.map(&{&1, k}) 
               end)
               |> List.flatten()
               |> Enum.into(%{})
    rest
    |> Enum.map(fn {ps, key} -> 
      if key == 0 do
        ps
      else
    {ps, key, fkey_map, zps} |> log(:pskey)
        fix_values(ps, key, fkey_map, zps)
      end
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.count()
  end

  def fix_values(ps, key, fkey_map, zps) do
    up_key = fkey_map |> Map.get(key)
    {kv, pat} = Map.get(zps, up_key) |> Map.get(key)
    ps = ps
    |> Enum.map(fn value -> 
      sub(kv, convert(value, pat))
    end)
    if up_key == 0 do
      ps
    else
      fix_values(ps, up_key, fkey_map, zps)
    end
  end
  
  def resolve(result, zps) do
    fkey_map = zps 
               |> Enum.map(fn {k, v} ->
                 Map.keys(v) |> Enum.map(&{&1, k}) 
               end)
               |> List.flatten()
               |> Enum.into(%{})
    result = result |> Enum.reduce(%{}, fn {k, v}, new_ps -> 
      # fkeys = new_ps |> Enum.map(fn {k, _} -> k end)
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

  def to_zero(key, fkeys) do
    up_key = Map.get(fkeys, key)
    cond do
      up_key == 0 -> true
      is_nil(up_key) -> false
      true -> 
        to_zero(up_key, fkeys)
    end
  end


  def resolve(_, [], zps, _, _,_), do: zps
  # def resolve(_, _, zps, _, _), do: zps

  def resolve({s0k, s0}, tail, zps, zp, rest, next_rest) do
    s0k |> log(:s0k)
    {fail, ps} = tail
                 # |> Enum.filter(fn {k, _} -> k != s0k end)
                 |> Enum.map(fn {k, v} -> 
                   # if k != s0k and k != Map.get(fkey_map, s0k)  do
                     # and to_zero(s0k, fkey_map) do
                   if k != s0k do
                     {k, find_s(s0, v)} 
                   else
                     {k, {}}
                   end
                 end)
                 |> Enum.split_with(fn {_, v} -> v == {} end)
    zps = if ps != [] do
      ps = ps |> Enum.into(%{})
      Map.update(zps, zp, ps, fn old-> 
        old |> Map.merge(ps)
        |> log(:ps_merge)
      end)
    else
      zps
    end
      |> log(:zps)
    fkey_map = zps 
               |> Enum.map(fn {k, v} ->
                 Map.keys(v) |> Enum.map(&{&1, k}) 
               end)
               |> List.flatten()
               |> Enum.into(%{})
    if tail == [] do
      # resolve(zps, zps)
      zps
    else
      tail = tail
      |> Enum.reject(fn {k, _} -> 
        {k, fkey_map}
        to_zero(k, fkey_map)
      end)
        |>log(:to_zero)
      tail|>Enum.map(fn {k,_}->k end)|>log(:tail_keys)
      # fail_keys = fail|>Enum.map(fn {k,_} -> k end)
      #             |>log(:fail_keys)
      # tail = Map.take(tail, fail_keys)
      [{zp, _}=head | rest] = if rest == [], do: next_rest, else: rest
      resolve(head, tail, zps, zp, rest,next_rest)
    end
  end

  def find_s(s0, s1) do
    vs0 = Map.values(s0)
          |> Enum.sort()
    vs1 = Map.values(s1)
          |> Enum.sort()
    # vs = (vs0 ++ vs1)
    #        |> Enum.group_by(&(&1))
    #        |> Enum.reject(fn {_,v}->length(v)==1 end)
    #        |> Enum.map(fn {k, _}->k end)
    vs = for v1 <- vs0 do
      for v2 <- vs1, v1 == v2 do
        v1
      end
    end 
    vs = vs |> List.flatten()
    share0 = findp(s0, vs)
    share1 = findp(s1, vs)
    keys = for key <- Map.keys(share0) do
      for key1 <- Map.keys(share1), key == key1 do
        key
      end
    end
    keys=List.flatten(keys)
    sps = keys 
    |> Enum.map(fn key -> {Map.get(share0, key), Map.get(share1, key)} end)
    # share0
    # |> Enum.map(fn {k, v} -> {v, Map.get(share1, k)} end)
    # |> Enum.reject(fn {v1, v2} -> is_nil(v1) or is_nil(v2) end)
    # |> Enum.take(2)
    length(sps)|>log(:sps_length)
    if length(sps) >= 12 do
      sps |> cal_all()
    else
      {}
    end
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
    pat
    |> Enum.map(fn p -> Map.get(values, p) end)
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
      # 可能冲突?
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

