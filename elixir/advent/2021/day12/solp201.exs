defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input2.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    input = ~s(start-A
start-b
A-c
A-b
b-d
A-end
b-end) |> String.split(~r{\n}, trim: true)
    input = parse_input()
    pairs =
      input
      |> Enum.map(fn line ->
        [node1, node2] = line |> String.split("-", trim: true)
        cond do
          node1 == "start" or node2 == "end" -> {node1, node2}
          node2 == "start" or node1 == "end" -> {node2, node1}
          true -> [{node1, node2}, {node2, node1}]
        end
      end)
      |> List.flatten()

    paths = pairs 
      |> Enum.filter(fn {k,_} -> k !== String.upcase(k) and k not in ["start", "end"] end)
      |> Enum.map(fn {k, _} -> k end)
      |> Enum.uniq()
      |> Enum.map(fn k -> {"start", ["start"], {k,2}} end)

    find_path(paths, pairs, [])
    |> Enum.uniq()
    |> Enum.count()
  end

  def find_path([], _, end_paths) do
    end_paths
  end

  def find_path(paths, pairs, end_paths) do
    # IO.inspect(end_paths, label: "end_paths")
    [{prev, path, {small, count}} | tail] = paths

    end_paths =
      # if prev == "end" and path not in end_paths do
      if prev == "end" do
        [path | end_paths]
      else
        end_paths
      end
    nexts =
      pairs
      |> Enum.filter(fn {k, _} -> k == prev end)
      |> Enum.map(fn {_, v} -> v end)

    tail =
      if nexts != [] do
        new_paths = nexts 
                    |> Enum.filter(fn next -> 
                      cond do
                        next == small ->
                          count > 0
                        next != String.upcase(next) and next != "end" ->
                          next not in path
                        true -> true
                      end
                    end)
                    |> Enum.map(fn next -> 
                      count = if count > 0 and next == small, do: count-1, else: count
                      {next, [next | path], {small, count}} 
                    end)
        tail ++ new_paths
      else
        tail
      end

    find_path(tail, pairs, end_paths)
  end
end


Advent.Day.exec()
|> IO.inspect(charlists: :list)
