defmodule Advent.Day do
   
  def parse_input() do
     File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def flash() do

  end

  def adjacent_keys({i,j}) do
    [
      {i-1,j-1},
      {i-1,j},
      {i-1,j+1},
      {i,j-1},
      {i,j+1},
      {i+1,j-1},
      {i+1,j},
      {i+1,j+1},
    ]
  end

  def inc(key, data) do
    case data[key] do
      9 -> 
        data = Map.put(data, key, :flash)
        update(adjacent_keys(key), data)
      :flash ->
        data
      -1 ->
        data
      v -> 
        Map.put(data, key, v+1)
    end
  end

  def update([], data), do: data

  def update(keys, data) do
    keys = keys |> Enum.reject(fn {i,j} -> i == 0 or j == 0 end)
    # IO.inspect(keys, label: "update keys")
    # IO.inspect(data, label: "update data")
    [key | tail] = keys
    data = inc(key, data)
    update(tail, data)
  end

  def inc_data(data) do
    update(Map.keys(data), data)
  end

  def step(data, 0), do: {data,lights}

  def step(data, steps) do
    data = inc_data(data)
    no_flash = (data 
             |> Enum.reject(fn {_, v} -> v==:flash end)
             |> Enum.count())
    if no_flash == 0 do
      steps
    else
      data = data
             |> Enum.map(fn 
               {k,:flash} -> {k, 0}
               {k, v} -> {k, v}
             end)
             |> Enum.into(%{})
      step(data, lights, steps+1)
    end
  end

  def exec() do
    data = parse_input()
           |> Enum.map(fn line -> 
             line
             |> String.split("", trim: true)
             |> Enum.map(&(Integer.parse(&1) |> elem(0)))
           end)
           |> Enum.map(&([-1] ++ &1 ++ [-1]))
    col = length(Enum.at(data, 0))
    new_row = [List.duplicate(-1, col+2)]
    data =  new_row ++ data ++ new_row
    row = length(data)
    data = data 
           |> Enum.map(&List.to_tuple(&1))
           |> List.to_tuple()
    data = 0..row-1
    |> Enum.reduce(%{}, fn j, points -> 
      row = elem(data, j)
      new_points = 0..col-1
      |> Enum.reduce(points, fn i, new_points -> 
        Map.put(new_points, {i, j}, elem(row, i))
      end)
      Map.merge(points, new_points)
    end)
    step(data, 0)
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
