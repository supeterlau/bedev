defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     # File.read!('./input2.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
#    input = ~s(start-A
#start-b
#A-c
#A-b
#b-d
#A-end
#b-end)
    input = parse_input()

    pairs =
      input
      # |> String.split(~r{\n}, trim: true)
      |> Enum.map(fn line ->
        [node1, node2] = line |> String.split("-", trim: true)
        cond do
          node1 == "start" or node2 == "end" -> {node1, node2}
          node2 == "start" or node1 == "end" -> {node2, node1}
          true -> [{node1, node2}, {node2, node1}]
        end
      end)
      |> List.flatten()
|> IO.inspect(charlists: :list)

    find_path([{"start", ["start"]}], pairs, [])
    |> Enum.count()
  end

  def find_path([], _, end_paths) do
    end_paths
  end

  def find_path(paths, pairs, end_paths) do
    [{prev, path} | tail] = paths

    end_paths =
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
                        next != String.upcase(next) and next != "end" ->
                          next not in path
                        true -> true
                      end
                    end)
                    |> Enum.map(fn next -> {next, [next | path]} end)
        tail ++ new_paths
      else
        tail
      end

    find_path(tail, pairs, end_paths)
  end
end


Advent.Day.exec()
|> IO.inspect(charlists: :list)
