defmodule Advent.Day do
  def parse_input() do
     File.read!('./input.txt') |> String.split(~r{\n\n}, trim: true)
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
    cond do
      scores |> Enum.sum() == length(parsed) -> {:done, head}
      true -> {:cont, head}
    end
  end

  def check_groups(number, groups, ids, result \\ {})

  def check_groups(_, [], ids, result), do: result

  def check_groups(number, groups, ids, {done_head, done_number, result}) do
    # done_head |> IO.inspect()
    # groups|>IO.inspect(label: "before")
    ids |> IO.inspect()
    groups = if done_head == {} do
      groups
    else
      {idx, _, _} = done_head
      ids = if length(ids) > 0, do: ids |> Enum.reject(&(&1 == idx)), else: ids
      if length(ids) == 0 do
        groups
      else
        groups |> Enum.reject(&(elem(&1, 0) == idx))
      end
    end
    # groups|>IO.inspect(label: "after")
    if groups == [] do
      check_groups(number, groups, ids, {done_head, done_number, result})
    else
      [head | tail] = groups 
      case check(number, head) do
        {:done, head} ->
          head |> IO.inspect()
          if done_number == "" do
            {id, _, _} = head
            ids = if length(ids) > 0, do: ids |> Enum.reject(&(&1 == id)), else: ids
            check_groups(number, tail, ids, {head, number, [head | result]})
          else
            {done_id, _, _} = done_head
            {id, _, _} = head
            if done_id == id do
              check_groups(number, tail, ids, {done_head, done_number, [head | result]}) 
            else
              ids = if length(ids) > 0, do: ids |> Enum.reject(&(&1 == id)), else: ids
              check_groups(number, tail, ids, {head, number, [head | result]}) 
            end
          end
        {:cont, head} ->
          check_groups(number, tail, ids, {done_head, done_number, [head | result]})
          # if done_head == {} do
          # else
          #   {idx, _, _} = done_head
          #   if elem(head, 0) == idx do
          #     check_groups(number, tail, {done_head, done_number, result})
          #   else
          #     check_groups(number, tail, {done_head, done_number, [head | result]})
          #   end
          # end
      end
    end
  end

  # {board, last_marked, parsed_boards}
  # {{}, "", parsed_boards}
  def process_numbers(numbers, data, result, board_ids)

  def process_numbers([], data, result, _), do: result

  def process_numbers(numbers, data, result, board_ids) do
    [head | tail] = numbers
    {done_head, _, data} = result
    # data |> IO.inspect(label: "process")
    board_ids = if done_head != {} do
      {id, _, _} = done_head
      board_ids |> Enum.reject(&(&1==id))
    else
      board_ids
    end
    if board_ids != [] do
      process_numbers(tail, data, check_groups(head, data|>Enum.reverse(), board_ids, {done_head, "", []}), board_ids)
    else
      result
    end
  end

  def process_numbers(numbers, data, board_ids) do
    # [head | tail] = numbers |> Enum.reverse()
    [head | tail] = numbers
    process_numbers(tail, data, check_groups(head, data, board_ids, {{}, "", []}), board_ids)
  end

  def parse_int(string), do: Integer.parse(string) |> elem(0)

  def sum_unmarked({board_id, _, _}, boards) do
    for {idx, numbers, scores} <- boards 
    |> Enum.filter(fn {idx,_,_} -> idx==board_id end) do
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
    {board, number, marked_boards} = process_numbers(numbers |> String.split(",",trim: true), parsed_boards, 0..(Enum.count(boards)-1)|> Enum.to_list())
                                     |> IO.inspect()
    sum_unmarked(board, marked_boards) * parse_int(number)
    |> IO.inspect()
  end
end

Advent.Day.exec()

