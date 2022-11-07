defmodule Advent.Day1 do

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

  def win_map(total) do
    map = for sp <- 0..10 do
      for s <- 0..total-1 do
        for copy <- split_copies() do
          {sp, s, copy}
        end
      end
    end
    |>List.flatten()
    {wmap, lmap} = map |>Enum.split_with(fn {sp, s, copy} -> 
      {_, s} = split_play(sp, s, copy)
      s >= total
    end)
    wmap = wmap|> Enum.group_by(fn {sp, s, c} -> {sp, s, c} end)
    |> Enum.map(fn {k, v} -> {k, length(v)} end)
    |> Enum.into(%{})
    lmap = lmap |> Enum.map(fn {sp, s, copy} ->
      {{sp, s, copy},split_play(sp, s, copy)}
    end)
    |> Enum.into(%{})
    {wmap, lmap}
  end

  def round(games_map, {c1, c2}, 0, _,_) do
    {games_map, {c1, c2}}
  end

  def handle_pair({p1, p2}, win_map, lose_map) do
    tp1 = Map.get(win_map, p1)
    if is_nil(tp1) do
      tp2 = Map.get(win_map, p2)
      if is_nil(tp2) do
        np1 = Map.get(lose_map, p1)
        np2 = Map.get(lose_map, p2)
        start_map(np1, np2)
      else
        {0,1}
      end
    else
      {1,0}
    end
  end

  def round(_, {c1, c2}, 0, _, _) do
    {c1, c2}
    |>log()
  end

  # %{{{p1,copy1}, {p2,copy2}} => 1}
  def round(games, {c1, c2}, n, win_map, lose_map) do
    {games, c1, c2}= games
    |> Enum.reduce({%{}, c1, c2}, fn {pair, count}, {new_games, ic1, ic2} -> 
      {map, c1, c2} = case handle_pair(pair, win_map, lose_map) do
        {0,1} -> {%{}, 0, 1}
        {1, 0} -> {%{}, 1,0}
        map -> {map, 0,0}
      end
        {Map.merge(new_games, map), ic1+c1, ic2+c2}
    end)
    round(games, {c1, c2}, n-1, win_map, lose_map)
  end

  def check({sp, s}, copy, cache) do
    if Map.get(cache, {{sp, s}, copy}) do
      true
    else
      {_sp, s} = split_play(sp, s, copy)
      s >= 21
    end
  end

  def start_map({sp1, s1}, {sp2, s2}) do
    for copy1 <- split_copies do
      for copy2 <- split_copies do
        {{{sp1,s1,copy1}, {sp2,s2,copy2}}, 1}
      end
    end
    |>List.flatten()
    |> Enum.into(%{})
  end

  def exec() do
    start1 = 4
    start2 = 8

    # start1 = 1
    # start2 = 5

    {win_map,lose_map} = win_map(21)
                         # |>log()
    round(
      start_map({start1,0}, {start2, 0}),
      {0, 0},
      3,
      win_map,
      lose_map
    )
    |> log(:round)
    :ok
  end
end
