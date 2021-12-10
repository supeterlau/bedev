defmodule Advent.Day do
    @scores Enum.zip(
      "}])>" |> String.split("", trim: true),
      [1197,57,3,25137]
    ) |> Enum.into(%{})
   
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def check(tokens) do
    legals = Regex.run(~r/\{\}|\(\)|\[\]|\<\>/, tokens)

    tokens = Regex.split(~r/\{\}|\(\)|\[\]|\<\>/, tokens, trim: true)
           |> Enum.join()
    if legals == nil do
      illegals = Regex.run(~r/[\{\[\(\<][\}\]\)\>]/, tokens)
      if illegals != nil do
        hd(illegals)|>String.last()
      else
        :ok
      end
    else
      check(tokens)
    end
  end

  def exec() do
    parse_input()
    |> Enum.map(&(check(&1)))
    |> Enum.reject(&(&1==:ok))
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {k,v} -> @scores[k] * length(v) end)
    |> Enum.sum()
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list, label: "exec")
