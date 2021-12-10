defmodule Advent.Day do
    @token_map Enum.zip(
      "{[(<" |> String.split("", trim: true),
      "}])<" |> String.split("", trim: true)
    ) |> Enum.into(%{})
   
  def parse_input() do
     File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
  end

  def check_pairs([]) do
    :ok
  end

  def check_pairs(pairs) do
    [head | tail] = pairs
    head |> IO.inspect(charlists: :list, label: "check_pairs")
    if head not in @token_map do
      elem(head, 0)
    else
      check_pairs(tail)
    end
  end

  def check_chunk(chunk) do
    chunk |> IO.inspect(charlists: :list, label: "chunk")
    if chunk == [] do
      :ok
    else
      pairs = Enum.zip(chunk, chunk |> Enum.reverse())
      check_pairs(pairs)
    end
  end

  def check([], _) do
    :ok
  end

  def check(tokens, head_idx) do
    tokens
|> IO.inspect(charlists: :list)

    head = tokens |> hd()
    # head_idx = 0
    if head in Map.keys(@token_map) do
      head_right = @token_map[head]
      case Enum.find_index(tokens, fn token -> token == head_right end) do
        nil -> head
        idx -> 
          chunk = Enum.slice(tokens, head_idx, idx-head_idx+1)
            |> IO.inspect(charlists: :list)
          case check_chunk(chunk) do
            :ok ->
              tokens = Enum.drop(tokens, idx-head_idx+1)
              check(tokens, 0)
            token -> token
          end
      end
    else
      head
    end
  end

  def exec() do
    line = "{([(<{}[<>[]}>{[]{[(<()>"
           |> String.split("", trim: true)
    check(line, 0)
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list, label: "exec")
