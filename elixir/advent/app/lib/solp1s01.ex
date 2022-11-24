defmodule Advent.DayP101 do

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

  def range_cubes(range) do
    for x <- range do
      for y <- range do
        for z <- range do
          {{x,y,z}, 0}
        end
      end
    end
    |> List.flatten()
    |> Enum.into(%{})
  end

  def step_cubes([rangex, rangey, rangez], cmd, range) do
    value = if cmd == "on", do: 1, else: 0
    for x <- rangex, x in range do
      for y <- rangey, y in range do
        for z <- rangez, z in range do
          {{x,y,z}, value}
        end
      end
    end
    |> List.flatten()
    |> Enum.into(%{})
  end

  def parse_step(step) do
    [cmd, cubes] = step |> String.split(" ", trim: true)
    cubes = cubes |> String.split(",", time: true)
            |> Enum.map(&(Code.eval_string(&1)|>elem(0)))
    {cmd, cubes}
  end

  def fetch_cubes(step, range) do
    {cmd, cube_ranges} = parse_step(step)
    step_cubes(cube_ranges, cmd, range)
  end

  def apply_step(cubes, step, range) do
    apply_cubes = fetch_cubes(step, range)
    Map.merge(cubes, apply_cubes, fn _, v1, v2 -> 
      cond do
        v1 == v2 -> v1
        true -> v2
      end
    end)
  end

  def apply_steps(cubes, [], _), do: cubes

  def apply_steps(cubes, steps, range) do
    [head | tail] = steps
    cubes = apply_step(cubes, head, range)
    apply_steps(cubes, tail, range)
  end

  def count_on(cubes) do
    cubes
    |> Enum.filter(fn {_, v}->v==1 end) |> Enum.count()
  end

  def exec() do
    parse_input()
    |> log()
    :ok
  end
end
