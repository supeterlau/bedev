defmodule Advent.Day do
  # 
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
    mboards ++ cols
  end

  def parse_boards(boards) do
    boards
    |> Enum.with_index()
    |> Enum.map(fn {board, idx} -> 
      parse_board(board)
      |> Enum.map(&({idx, &1, []}))
    end)
    |> List.flatten()
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

  def filter_groups(groups, ids, {}), do: {groups, ids}

  def filter_groups(groups, [id], {done_id,_,_}) when id == done_id, do: {groups, [id]}

  def filter_groups(groups, [id], {done_id,_,_}) do
    {groups |> Enum.reject(&(elem(&1, 0) == done_id)), [id]}
  end

  def filter_groups(groups, ids, {done_id,_,_}) do
    {groups |> Enum.reject(&(elem(&1, 0) == done_id)), ids |> Enum.reject(&(&1==done_id))}
  end

  def check_groups(number, groups, ids, result \\ {})

  def check_groups(_, [], ids, result), do: {result, ids}

  def check_groups(number, groups, ids, {done_head, done_number, result}) do
    if done_head != {} do
      # result |> IO.inspect(label: "result")
      # {groups, ids, done_head} |> IO.inspect(label: "before")
    end
    {groups, ids} = filter_groups(groups, ids, done_head)
    if done_head != {} do
      # {groups, ids, done_head} |> IO.inspect(label: "after")
    end
    if groups == [] do
      check_groups(number, groups, ids, {done_head, done_number, result})
    else
      [head | tail] = groups 
      case check(number, head) do
        {:cont, head} ->
          check_groups(number, tail, ids, {done_head, done_number, [head | result]})
        {:done, head} ->
          {id, _, _} = head
          cond do
            done_number == ""  -> 
              ids = reject_id(ids, id)
              check_groups(number, tail, ids, {head, number, [head | result]})
            done_number != "" ->
              {done_id, _, _} = done_head
              ids = reject_id(ids, id)
              if done_id == id do
                check_groups(number, tail, ids, {done_head, done_number, [head | result]})
              else
                check_groups(number, tail, ids, {head, number, [head | result]})
              end
          end
      end
    end
  end

  def reject_number_id(ids, {{},_,_}), do: ids
  
  def reject_number_id(ids, {{id,_,_},_,_}), do: ids |> Enum.reject(&(&1 == id))

  def reject_id(ids, id), do: if length(ids) > 1, do: ids |> Enum.reject(&(&1 == id)), else: ids

  def process_numbers(numbers, data, result)

  def process_numbers([], _, {result, _}), do: result

  def process_numbers(numbers, _, {result, ids}) do
    [head | tail] = numbers
    {done_head, done_number, data} = result
    data = data |> Enum.filter(&(elem(&1,0) in ids))
    head |> IO.inspect()
    {ids, result} |> IO.inspect(charlists: :as_list)
    ids = reject_number_id(ids, result)
    if ids != [] do
      process_numbers(tail, data, check_groups(head, data |> Enum.reverse(), ids, {done_head, done_number, []}))
    else
      result
    end
  end

  def process_numbers(numbers, data, board_ids) do
    [head | tail] = numbers
    process_numbers(tail, data, check_groups(head, data, board_ids, {{}, "", []}))
  end

  def exec() do
    # find all_marked
    # filter out groups of this board
    #
    [numbers | boards] = parse_input()
    parsed_boards = boards 
    |> parse_boards()
    {board, number, marked_boards} = process_numbers(numbers |> String.split(",",trim: true), parsed_boards, 0..(Enum.count(boards)-1)|> Enum.to_list())
    sum_unmarked(board, marked_boards) * parse_int(number)
    |> IO.inspect()
  end

  def parse_int(string), do: Integer.parse(string) |> elem(0)

  def sum_unmarked({board_id, _, _}, boards) do
    with boards <- Enum.filter(boards, fn {idx, _, _} -> idx==board_id end) do
      for {_idx, numbers, scores} <- boards do
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
  end
end

Advent.Day.exec()

