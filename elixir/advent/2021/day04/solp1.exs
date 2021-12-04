defmodule Advent.Day do
  def parse_input() do
     File.read!('./input1.txt') |> String.split(~r{\n\n}, trim: true)
  end

  def parse_board(board) do
    rows = board |> String.split("\n", trim: true)
    mboards = rows |> Enum.map(&(String.split(&1, " ", trim: true)))
            
    cols = mboards
    |> hd()
    |> Enum.with_index()
    |> Enum.map(fn {_, idx} -> 
      for m <- mboards do
        Enum.at(m, idx)
      end
    end)
    mboards ++  cols
  end

  def parse_boards(boards) do
    boards
    |> Enum.with_index()
    |> Enum.map(fn {board, idx} -> 
      parse_board(board)
      |> Enum.map(&({idx, &1, []}))
    end)
    |> List.flatten()
    # {board_number, numbers}
  end

  def check(number, {idx, parsed, scores}) do
    scores = parsed
             |> Enum.with_index()
             |> Enum.map(fn {elem, idx} -> 
               old_value = Enum.at(scores, idx)
               old_value = if is_nil(old_value), do: 0, else: old_value
               cond do
                 number == elem ->
                   if old_value == 0, do: 1, else: old_value
                 number != elem ->
                   old_value
               end
             end)
    head = {idx, parsed, scores}
    if scores |> Enum.sum() == length(parsed) do
      {:done, head}
    else
      {:cont, head}
    end
  end

  def check_groups(number, groups, result \\ {})

  def check_groups(_, [], result), do: result

  # def check_groups(number, groups, {done_head, done_number, result}) do
  def check_groups(number, groups, {done_head, done_number, unmarked_numbers, result}) do
    groups |> IO.inspect()
    [head | tail] = groups 
    case check(number, head) do
      {:done, head} -> 
        # if done_number == "" do
        {idx, _, _} = done_head
        if idx in unmarked_numbers do
          unmarked_numbers = unmarked_numbers |> Enum.reject(&(&1 == idx))
          check_groups(number, tail, {head, number, unmarked_numbers, [head | result]})
        else
          check_groups(number, tail, {done_head, done_number, unmarked_numbers, [head | result]})
        end
      {:cont, head} ->
        check_groups(number, tail, {done_head, done_number, unmarked_numbers, [head | result]})
    end
  end

  # {board, last_marked, parsed_boards}
  # {{}, "", parsed_boards}
  def process_numbers(numbers, data, result)

  def process_numbers(numbers, data, unmarked_numbers) when is_list(unmarked_numbers)do
    [head | tail] = numbers
    process_numbers(tail, data, check_groups(head, data, {{}, "", unmarked_numbers,[] }))
  end

  def process_numbers([], data, result), do: result

  def process_numbers(numbers, data, result) do
    [head | tail] = numbers
    # {done_head, done_number, data} = result
    {done_head, done_number, unmarked_numbers,data } = result
    # if done_number == "" do
    if unmarked_numbers != [] do
      # process_numbers(tail, data, check_groups(head, data|>Enum.reverse(), {done_head, done_number, []}))
      process_numbers(tail, data, check_groups(head, data|>Enum.reverse(), {done_head, done_number, unmarked_numbers, []}))
    else
      result
    end
  end

  def process_numbers(numbers, data) do
    [head | tail] = numbers
    process_numbers(tail, data, check_groups(head, data, {{}, "", [], []}))
  end

  def parse_int(string), do: Integer.parse(string) |> elem(0)

  def sum_unmarked({board_idx, _, _}, boards) do
    for {idx, numbers, scores} <- boards 
    |> Enum.filter(fn {idx,_,_} -> idx==board_idx end) do
      numbers 
      |> Enum.with_index()
      |> Enum.filter(fn {_, idx} -> Enum.at(scores, idx) == 0 end)
      |> Enum.map(fn {elem, _} -> parse_int(elem) end)
    end
    |> List.flatten()
    |> (fn elems -> 
      Enum.take(elems, div(Enum.count(elems), 2))
    end).()
    |> Enum.sum()
  end

  def exec() do
    [numbers | boards] = parse_input()
    parsed_boards = boards 
    |> parse_boards()
    {board, number, marked_boards} = process_numbers(numbers |> String.split(",",trim: true), parsed_boards, 0..(length(boards)-1) |> Enum.to_list())
    |> IO.inspect()
    sum_unmarked(board, marked_boards) * parse_int(number)
    |> IO.inspect()
  end
end

Advent.Day.exec()

