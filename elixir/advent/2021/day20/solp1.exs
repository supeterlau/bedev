defmodule Advent.Day do

  def log(item, label) do
    IO.inspect(item, charlists: :list, label: label)
  end

  def log(item) do
    IO.inspect(item, charlists: :list)
  end
   
  def parse_input(input) do
     File.read!(input) |> String.split(~r{\n\n}, trim: true)
  end

  def parse_input() do
    # parse_input('./input1.txt')
    parse_input('./input.txt')
  end

  def convert(a) do
    case a do
      "." -> "0"
      "#" -> "1"
      "0" -> "."
      "1" -> "#"
      nil -> "."
      a -> a
    end
  end

  def get_value({x,y},target) do
    case target|>elem(y)|>elem(x) do
      "." -> "0"
      "#" -> "1"
    end
  end

  def extend_pixel(target) do
    target = target |> String.split(~r{\n}, trim: true)
             |> Enum.map(&String.split(&1, ~r{}, trim: true))
    rows = length(target)
    cols = length(target|>hd())
    ypad = List.duplicate(".", 2)
    xpad = List.duplicate(".", cols+4) |> List.duplicate(2)
    target = xpad ++ (target|>Enum.map(&(ypad ++ &1 ++ ypad))) ++ xpad
    rows = length(target)
    cols = length(target|>hd())
    target = target|>Enum.map(&List.to_tuple(&1)) |>List.to_tuple()
    target = 0..rows-1
    |> Enum.reduce(%{}, fn y, t1 -> 
      0..cols-1
      |> Enum.reduce(t1, fn x, t2 -> 
        Map.put(t2, {x, y}, get_value({x,y}, target))
      end)
    end)
    { target, rows, cols }
  end

  def print(target, rows, cols) do
    0..rows-1
    |>Enum.map(fn y -> 
      0..cols-1
      |>Enum.map(fn x -> 
        target|>Map.get({x,y}) |> convert()
      end)
    end)
  end

  def add({px, py}, {x,y}), do: {px+x,py+y}

  def cal_form(point, target, algo_str) do
    idx = -1..1
    |>Enum.map(fn y -> 
    -1..1 |> Enum.map(fn x -> 
        p = add(point,{x, y})
        case v = Map.get(target, p) do
          nil -> Map.get(target, point)
          v -> v
        end
      end)
      |> Enum.join()
    end)
    |> Enum.join()
    idx = idx|> String.to_integer(2)
    case algo_str |> String.at(idx) do
      "." -> "0"
      "#" -> "1"
    end
  end

  def next_point({x, y}, cols, rows) do
    cond do
      x<cols-1 -> {x + 1, y}
      x == cols-1 and y < rows-1 -> {0, y+1}
      x == cols-1 and y == rows-1 -> :done
    end
  end

  # {1,1}
  # cols-2, rows-2
  def process(result, target, point, cols, rows, algo_str) do
    new_value = cal_form(point, target, algo_str)
    result = Map.put(result, point, new_value)
    next = next_point(point, cols, rows)
    if next == :done do
      result
    else
      process(result, target, next, cols, rows, algo_str)
    end
  end

  def need_extend(target, rows, cols) do
    inf = Map.get(target, {0,0})
    target
    |> Enum.filter(fn {{x,y},_} -> 
      x == 1 or y == 1 or x == rows-2 or y == cols-2
    end)
    |> Enum.any?(fn {_, v} -> v != inf end)
  end

  def enhance_extend(target, rows, cols) do
    inf = Map.get(target, {0,0})
    new_rows = rows+2
    new_cols = cols+2
    target = target |> Enum.map(fn {{x, y}, v} -> 
      {{x+2,y+2}, v}
    end)
    extendx = for x <- [0,1, new_cols-1,new_cols] do
      for y <- 0..new_rows do
        {{x, y}, inf}
      end
    end
    extendy = for x <- 0..new_cols do
      for y <- [0,1,new_rows-1, new_rows] do
        {{x, y}, inf}
      end
    end
    # (extendx++extendy)
    target = (extendx++extendy++target)
    |> List.flatten()
    |> Enum.into(%{})
    {target, new_rows, new_cols}
  end

  def enhance(target, rows, cols, _, 0), do: {target, rows, cols}

  def enhance(target, rows, cols, algo, time) do
    init = for y <- 0..rows-1 do
      for x <- 0..cols-1 do
        {{x,y}, Map.get(target, {0,0})}
      end
    end |> List.flatten() |> Enum.into(%{})
    target = process(init, target,{0,0}, cols, rows,algo)
    # print(target, rows, cols)
    {target, rows, cols} = if need_extend(target,rows, cols) do
      enhance_extend(target, rows, cols)
    else
      {target, rows, cols}
    end
    enhance(target, rows, cols, algo, time-1)
  end

  def count(target) do
    target
    |>Enum.map(fn {_,v}-> Integer.parse(v)|>elem(0) end)
    |> Enum.sum()
  end

  def exec() do
    [algo, target] = parse_input()

    {target, rows, cols } = extend_pixel(target)
    {target, rows, cols} = enhance(target, rows, cols, algo, 2)
    # print(target, rows, cols)
    count(target)
    |>log()
    :ok
  end
end

# Advent.Day.exec()
# |> Advent.Day.log()
