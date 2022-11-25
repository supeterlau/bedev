defmodule Advent.DayP201 do

  def log(item, label) do
    IO.inspect(item, charlists: :list, label: label)
  end

  def log(item) do
    IO.inspect(item, charlists: :list)
  end
   
  def parse_input(input) do
     File.read!(input) |> String.split(~r{\n}, trim: true)
  end

  def parse_input() do
    parse_input('./input1.txt')
    # parse_input('./input.txt')
  end

  def parse_step(step) do
    [cmd, cubes] = step |> String.split(" ", trim: true)
    cubes = cubes |> String.split(",", time: true)
            |> Enum.map(&(Code.eval_string(&1)|>elem(0)))
            |> Enum.map(fn a..b -> {a, b} end)
    {cmd, cubes|>List.to_tuple()}
  end

  def include_range?({xl1, xh1}, {xl2, xh2}) do
    (xl1 <= xl2 and xh1 >=xh2) or
    (xl1 >= xl2 and xh1 <=xh2)
  end

  def include?(
    r1, r2
  ) do
    {r1,r2} |> log()
    0..2
    |> Enum.all?(&include_range?(elem(r1,&1), elem(r2, &1)))
  end

  def process_on(region, cmd_region, true, "on") do

  end
  def process_on(region, cmd_region, true, "off") do

  end
  def process_on(region, cmd_region, false, "on") do

  end

  def process_on(region, cmd_region, false, "off") do

  end

  # {:on, []}
  # {:off, []}
  def merge({state, state_region}, {cmd, cmd_region}) when state == cmd do
  end

  def merge({state, state_region}, {cmd, cmd_region}) when state != cmd do
  end

  # in t2 view
  def handle_range({t1, {rl1, rh1}}, {t2, {rl2, rh2}}) when t1 == t2 do
    r1 = {rl1, rh1}
    r2 = {rl2, rh2}
    # {outside, inside}
    {t1s, t2s} = cond do
      rl1 > rh2 -> {[], [r2]}
      rh1 == rh2 -> {[{rh2, rh2}], [rl2, rh2-1]}
      rl1 > rl2 and rl1 < rh2 and rh1 > rh2 ->
        {[{rl1, rh2}],[{rl2, rl1-1}]}
      rl1 > rl2 and rh1 == rh2 ->
        {[{rl1, rh1}],[{rl2, rl1-1}]}
      rl1 > rl2 and rh1 < rh2 ->
        {[r1], [{rl2, rl1-1},{rh1+1, rh2}]}
      rl1 == rl2 and rh1 >= rh2 ->
        {[r2], []}
      rl1 == rl2 and rh1 < rh2 ->
        {[r1], [rh1+1, rh2]}
      rl1 < rl2 and rh1 >= rh2 ->
        {[r2], []}
      rl1 < rl2 and rh1 < rh2 ->
        {[{rl2, rh1}], [{rh1+1, rh2}]}
      rh1 == rl2 ->
        {[{rl2,rl2}], [{rl2+1, rh2}]}
      rh1 < rl2 ->
        {[], [r2]}
    end
    |>log(:handle_range_eq)
    %{ :t1 => t1s, :t2 => t2s }
  end

  # in t1 view
  def handle_range({t1, {rl1, rh1}}, {t2, {rl2, rh2}}) when t1 != t2 do
        # %{t1 => t1s, t2 => t2s}
    r2 = {rl2, rh2}
    {t1s, t2s} = cond do
      rl1 > rh2 or rh1 < rl2 -> {[{rl1, rh1}], []}
      rl1 == rh2 ->
        {[{rl1+1, rh1}], [{rl1, rl1}]}
      rl1 >= rl2 and rh1 > rh2 ->
        {[{rh2+1, rh1}], [r2]}
      rl1 >= rl2 and rh1 <= rh2 ->
        {[], [{rl1, rh1}]}
      # rl1 < rl2
      rl1 < rl2 and rh1 > rh2 ->
        {[{rl1, rl2-1}, {rh2+1, rh1}], [r2]}
      rl1 < rl2 and rh1 <= rh2 -> {[{rl1, rl2-1}], [{rl2, rh1}]}
      rh1 == rl2 -> {[{rl1, rl2-1}], [{rl2,rl2}]}
    end
    |>log(:handle_range_neq)
    %{ t1 => t1s, t2 => t2s }
  end

  # [ [], [], [] ]
  def make_regions(regions) do
    for x <- Enum.at(regions, 0) do
      for y <- Enum.at(regions, 1) do
        for z <- Enum.at(regions, 2) do
          {x, y, z}
        end
      end
    end 
    |> List.flatten()
  end

  # {t1, {{x1l, x1h},{y1l,y1h},{z1l,z1h}}},
  # {t2, {{x2l, x2h},{y2l,y2h},{z2l,z2h}}}
  def handle_ranges( {t1, r1}, {t2, r2}) when t1 == t2 do
    sub_ranges = 0..2
    |> Enum.map(fn idx -> 
      handle_range({t1, elem(r1, idx)}, {t2, elem(r2, idx)})
    end)
    t1s = sub_ranges
          |> Enum.map (fn item -> 
            Map.get(item, :t1)
          end) 
          # |>log() # ???
    t1rs = make_regions(t1s)
    ts = sub_ranges
         |>Enum.map(fn item -> 
           Map.values(item) |> List.flatten()
         end)
    t2rs = make_regions(ts)
           |> Enum.filter(&(&1 not in t1rs))
    # {{t1, [r1]}, {t2, t2rs}}
    t2rs = t2rs |> Enum.map(&({t2, &1}))
    [{t1, r1} | t2rs]
  end

  def handle_ranges( {t1, r1}, {t2, r2}) when t1 != t2 do
    sub_ranges = 0..2
    |> Enum.map(fn idx -> 
      handle_range({t1, elem(r1, idx)}, {t2, elem(r2, idx)})
    end)
    t2s = sub_ranges
          |> Enum.map (fn item -> 
            Map.get(item, t2)
          end) 
          # |>log() # ???
    t2rs = make_regions(t2s)
    ts = sub_ranges
         |>Enum.map(fn item -> 
           Map.values(item) |> List.flatten()
         end)
    t1rs = make_regions(ts)
    |> Enum.filter(&(&1 not in t2rs))
    # {{t1, t1rs}, {t2, [r2]}}
    t1rs = t1rs |> Enum.map(&({t1, &1}))
    [{t2, r2} | t1rs]
  end

  def merge_t1r(t1rs) do
    # t1rs
    # |> Enum.group_by(fn {x, y, z})
  end

  def show_vertex([{xl,xh},{yl,yh},{zl,zh}]) do
    for x <- [xl, xh] do
      for y <- [yl, yh] do
        for z <- [zl, zh] do
          {x, y, z}
        end
      end
    end
    |> List.flatten()
  end

  def cal_on_region(states, {cmd, cmd_region}) do
    states
    |> Enum.reduce([], fn region, new_regions -> 
      is_include = include?(region, cmd_region)
      process_on(region, cmd_region, is_include, cmd)
      proc_regions = if include?(region, cmd_region) do

      else
        # not include
        if cmd == "on" do
          [region, cmd_region]
        else
          [region]
        end
      end
      proc_regions ++ new_regions
    end)
  end

  def cal_off_region(states, {cmd, region}) do

  end

  # %{off: [], on: []}
  def cal_region(%{on: on_region, off: off_region}, new_state) do
    cal_on_region(on_region, new_state)
    cal_off_region(off_region, new_state)
  end

  def process_steps(state, []) do
    state
  end

  def process_steps(state, steps) do
    [head_step | tail_step] = steps
    state = state
      |>log(:process_before)
    |> Enum.reduce([], fn region, new_state -> 
      states = handle_ranges(region, head_step)
      |>log(:process_steps)
      states ++ new_state
    end)
    process_steps(state, tail_step)
  end

  def count_region({{xl,xh},{yl, yh},{zl, zh}}) do
    (xh-xl+1) * (yh-yl+1) * (zh-zl+1)
  end

  def count_on(states) do
    states
    |> Enum.filter(fn {k,_} -> k == "on" end)
    |> log(:count_on)
    |> Enum.map(fn {k, region} -> count_region(region) end)
    |> Enum.sum()
  end

  def exec() do
    parse_input()
    |> log()
    :ok
  end
end
