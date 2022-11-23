defmodule Advent.Day do

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
    # {cmd, cubes|>List.to_tuple()}
    cmd = if cmd == "on", do: true, else: false
    [cmd | cubes] |> List.to_tuple()
  end

  def sum(ins, xs, ys, zs) do
    for [x1, x2] <- Enum.chunk_every(xs, 2, 1) do
      x1 |> log(:x1)
      ins_x = for {a, {ix1, ix2}, _, _}=item <- ins, ix1 <= x1 and x1 <= ix2 and a do
        item
      end
      for [y1, y2] <- Enum.chunk_every(ys, 2, 1) do
        ins_y = for {a, _, {iy1, iy2}, _}=item <- ins_x, iy1 <= y1 and y1 <= iy2 do
          item
        end
        for [z1, z2] <- Enum.chunk_every(zs, 2, 1) do
          ins_z = for {a,  _, _, {iz1, iz2}}=item <- ins_y, iz1 <= z1 and z1 <= iz2 do
            a
          end
          if ins_z == [] or not hd(ins_z) do
            0
          else
            (x2-x1)*(y2-y1)*(z2-z1)
          end
        end
        |> List.flatten()
        |> Enum.sum()
      end 
      |> List.flatten()
      |> Enum.sum()
    end
    |> List.flatten()
    |> Enum.sum()
  end

  def exec() do
    {ins, xs, ys, zs} = parse_input()
    |> Enum.reduce({[],[],[],[]}, fn step,{ins, xs, ys, zs} -> 
      {_, {x1, x2}, {y1, y2}, {z1,z2}} = result = parse_step(step)
      {[result|ins], [x1, x2+1]++xs,[y1,y2+1]++ys,[z1,z2+1]++zs}
    end)
    ins |> Enum.count() |> log()
    ins |> Enum.uniq() |> Enum.count() |> log()
    xs = xs|>Enum.sort()
    xs |> Enum.count()
         |>log()
    xs|>Enum.uniq()
         |> Enum.count()
         |>log()
    ys = ys|>Enum.sort()
    zs = zs|>Enum.sort()
    sum(ins, xs, ys, zs)
    |>log()
    :ok
  end
end

# https://www.reddit.com/r/adventofcode/comments/rmivfy/everyone_is_overcomplicating_day_22/
