defmodule Advent.Day do
    @scores Enum.zip(
      "}])>" |> String.split("", trim: true),
      # [1197,57,3,25137]
      [3,2,1,4]
    ) |> Enum.into(%{})

    @token_map Enum.zip(
      "{[(<" |> String.split("", trim: true),
      "}])>" |> String.split("", trim: true)
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
        :illegal
      else
        tokens
        |> String.split("", trim: true)
        |> Enum.map(&(@token_map[&1]))
        |> Enum.reverse()
      end
    else
      check(tokens)
    end
  end

  def cal_score(tokens) do
    tokens
    |> Enum.reduce(0, fn token, total -> 
      total * 5 + @scores[token]
    end)
  end

  def exec() do
    scores = parse_input()
    |> Enum.map(&(check(&1)))
    |> Enum.reject(&(&1==:illegal))
    |> Enum.map(&(cal_score(&1)))
    Enum.at(scores |> Enum.sort(), div(length(scores), 2))
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list, label: "exec")
