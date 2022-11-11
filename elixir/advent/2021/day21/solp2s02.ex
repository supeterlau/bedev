defmodule Advent.DayP02 do

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
    parse_input('./input1.txt')
    # parse_input('./input.txt')
  end

  def add(numbers, lvl \\ 0, max \\ 0) 

  def add(numbers, _, _) when numbers == [], do: {nil, []}

  def add(numbers, lvl, max) when lvl >= max, do: {nil, numbers}

  def add(numbers, lvl, max) do
    lvl = lvl + 1
    [head | tail] = numbers
    {lh, tail} = add(tail, lvl, max)
    {rh, tail} = add(tail, lvl, max)
    {{lh, head, rh}, tail}
  end

  def ptree({nil, v, nil}), do: log(v)

  def ptree({lh, v, rh}) do
    ptree(lh)
    log(v)
    ptree(rh)
  end

  def aexec() do
    numbers = 0..30 |> Enum.to_list()
    {tree, _} = add(numbers, 0, 5)
    tree |> ptree()
    :ok
  end

  def move(step, start) do
    dest = start + step
    reminder = rem(dest, 10)
    if reminder == 0, do: 10, else: reminder
  end

  def take_turn(start, result) do
    move(sum(result), start)
  end

  def sum(results), do: results|>Enum.sum()

  def play(sp, s, time, result) do
    presult = result |> Enum.map(&(&1 + 6 * time))
    sp = take_turn(sp, presult)
    s = s+sp
    {sp, s}
  end

  def roll({sp1, s1}, {sp2, s2}, round) do
    round = round + 1
    time = div(round-1, 2)
    {sp1, s1} = play(sp1, s1, time, [1,2,3])
    {s1, round}
    if s1 >= 1000 do
      s2 * round * 3
    else
      round = round + 1
      {sp2, s2} = play(sp2, s2, time, [4,5,6])
      {s2, round}
      if s2 >= 1000 do
        s1 * round * 3
      else
        roll({sp1, s1},{sp2, s2}, round)
      end
    end
  end

  def split_copies() do
    for x1 <- 1..3 do
      for x2 <- 1..3 do
        for x3 <- 1..3 do
          {x1,x2,x3}
        end
      end
    end |> List.flatten()
    |> Enum.map(&Tuple.to_list(&1))
  end

  def split_play(sp, s, copy) do
    sp = take_turn(sp, copy)
    s = s+sp
    {sp, s}
  end

  def ssum(results) do
    results 
    |> log(:ssum)
    |> Enum.reduce(
      {{:p1, 0}, {:p2, 0}},
      fn {{:p1,pv1}, {:p2, pv2}}, {{:p1,v1}, {:p2, v2}} -> 
        {{:p1, pv1+v1}, {:p2, pv2+v2}}
      end
    )
  end

  def rplay({{sp1, s1, count1}, {sp2, s2, count2}}) do
    for copy <- split_copies() do
      {sp1, s1} = split_play(sp1, s1, copy)
      s1|>log()
      if s1 >= 10 do
        {{:p1, 1},{:p2, 0}}
      else
        for copy <- split_copies() do
           {sp2, s2} = split_play(sp2, s2, copy)
           s2|>log()
           if s2 >= 10 do
             {{:p1, 0},{:p2, 0}}
           else
             rplay({{sp1, s1, count1}, {sp2, s2, count2}})
           end
        end
        |> ssum()
      end
    end
    |> ssum()
  end

  def rsplit(games) do
    copies = split_copies()
    for game <- games do
      rplay(game)
    end
    |> List.flatten() |> ssum()
  end

  def rrplay(games, gm) do
    win_score = 5
    gm |> log(:before)
    gm = for {{sp1, s1}, {sp2, s2}}=game <- games, reduce: gm do
      acc ->
        for copy <- split_copies(), reduce: acc do
          acc1 -> 
            {sp1, s1} = split_play(sp1, s1, copy)
            if s1 >= win_score do
              {game_count, new_acc} = Map.pop(acc1, game, 1)
              new_acc |> Map.update(:s1, game_count, fn old -> old+ game_count end)
            else
              for copy <- split_copies(), reduce: acc1 do
                acc2 ->
                  {sp2, s2} = split_play(sp2, s2, copy)
                  if s2 >= win_score do
                    {game_count, new_acc} = Map.pop(acc2, game, 1)
                    new_acc |> Map.update(:s2, game_count, fn old -> old+ game_count end)
                  else
                    new_game = {{sp1, s1}, {sp2, s2}}
                    acc2 |> Map.update(new_game, 1, fn n -> n+1 end)
                  end
              end
            end
        end
    end
    # gm |> log(:after)
    Map.keys(gm)|>length()|>log(:gm_len)
    gm |> Map.take([:s1,:s2]) |>log()
    if Map.keys(gm)|>length() > 2 do
      Map.keys(gm) |> Enum.filter(&(&1 not in [:s1,:s2]))
      |> rrplay(gm)
    else
      gm
    end
  end

  def to_total([], _, total) do
    total
  end

  def win_map(total) do
    for sp <- 1..10 do
      for s <- 0..total-1 do
        for copy <- split_copies() do
          {sp, s, copy}
        end
      end
    end
    |>List.flatten()
    |>Enum.filter(fn {sp, s, copy} -> 
      {_, s} = split_play(sp, s, copy)
      s == total
    end)
  end

  def to_total(games, target, total) do
    [{sp,s,n} | tail] = games
    n = n+1
    {dones, games} = for copy <- split_copies() do
      {sp, s} = split_play(sp, s, copy)
      {sp, s, n}
    end
    |> Enum.split_with(fn {sp, s, _} -> s>= target end)
    total = dones ++ total
    tail = games ++ tail
    to_total(tail, target, total)
  end

  def sum_total(total) do
    total
    |> Enum.group_by(fn {_, _, n} -> n end)
    |> Enum.map(fn {k, v} -> {k, length(v)} end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.sum()
  end

  def exec() do
    start1 = 4
    start2 = 8

    # start1 = 1
    # start2 = 5
    # roll({start1, 0}, {start2, 0}, 0)
    # rrplay([{{start1, 0}, {start2, 0}}], %{})

    # to_total([{start1, 0, 0}], 21, [])
    # |> sum_total()
    # |> log()
    # to_total([{start2, 0, 0}], 21, [])
    # |> sum_total()
    win_map(21)
    |> log()
    |>length()|>log()
    :ok
  end
end
