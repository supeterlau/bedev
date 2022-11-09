defmodule Advent.DayP1 do

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

  def exec() do
    start1 = 4
    start2 = 8

    # start1 = 1
    # start2 = 5
    # roll({start1, 0}, {start2, 0}, 0)
    rsplit([{{start1,0,0}, {start2,0,0}}])
    |> log()
    :ok
  end
end
