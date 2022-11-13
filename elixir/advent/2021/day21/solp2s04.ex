defmodule Advent.DayP04 do

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

  # %{{p1,p2} => n}
  def rrplay(games, {c1,c2}, win_map, lose_map) do
    if Enum.empty?(games) do
      {c1,c2}
    else
      {new_games, {nc1, nc2}} 
      = games
        |> Enum.reduce({%{}, {c1, c2}}, fn {{p1,p2}, n}, {ngames, {nc1, nc2}} -> 
        nnc1 = nc1 + Map.get(win_map, p1, 0) * n
        lose_p1 = 27 - Map.get(win_map, p1, 0)
        p1sm = Map.get(lose_map, p1, %{})
        p1s = Map.keys(p1sm)
        if p1s == [] do
          {ngames, {nnc1, nc2}}
        else
          nnc2 = nc2 + Map.get(win_map, p2, 0) * lose_p1 * n
          p2sm = Map.get(lose_map, p2, %{})
          lose_p2 = 27 - Map.get(win_map, p2, 0)
          p2s = Map.keys(p2sm)
          if p2s == [] do
            {ngames, {nnc1, nnc2}}
          else
            new_games = for p1 <- p1s do
              for p2 <- p2s do
                # {{p1, p2}, 27}
                # {{p1, p2}, Map.get(p1sm, p1) * Map.get(p2sm, p2)}
                {{p1, p2}, lose_p1 * lose_p2}
              end
            end |> List.flatten()
            |> Enum.group_by(fn {k, v} -> k end)
            |> Enum.map(fn {k,v}->{k, v|>Enum.map(fn {k, v} -> v end)|>Enum.sum() } end)
            |> Enum.into(%{})
            |> Map.merge(ngames, fn _, v1, v2 -> v1+v2 end)
        {new_games, {nnc1, nnc2}}
          end
        end
      end)
      rrplay(new_games, {nc1, nc2}, win_map, lose_map)
    end
  end

  def win_map(total) do
    map = for sp <- 1..10 do
      for s <- 0..total+10-1, s != total do
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
    wmap = wmap|> Enum.group_by(fn {sp, s, _} -> {sp, s} end)
    |> Enum.map(fn {k, v} -> {k, length(v)} end)
    |> Enum.into(%{})
    |>log()
    lmap = lmap |> Enum.map(fn {sp, s, copy} ->
      {{sp, s, copy},split_play(sp, s, copy)}
    end)
    |> Enum.group_by(fn {{sp, s, _}, v} -> {sp, s} end)
    |> Enum.map(fn {k, v}->
      {
        k,
        v 
        |> Enum.map(fn {_, next} -> next end) 
        |> Enum.group_by(&(&1)) 
        |> Enum.map(fn {k,v}-> {k, length(v)} end)
        |> Enum.into(%{})
      }
    end)
    |> Enum.into(%{})
    {wmap, lmap}
  end

  def round(games_map, {c1, c2}, 0, _,_) do
    {games_map, {c1, c2}}
    |> log()
  end

  def round(games_map, {c1, c2}, n, win_map, lose_map) do
    {ngmap, {nc1, nc2}} = games_map
    |> Enum.map(fn {{p1, p2}, count} -> 
      wnc1 = Map.get(win_map, p1, 0) * count
      {Map.get(win_map, p1, 0) , count}
      lnc1 = 27 - Map.get(win_map, p1, 0)
      p1sm = Map.get(lose_map, p1, %{})
      p1s = Map.keys(p1sm)
      if p1s == [] do
        {%{}, {wnc1, 0}}
      else
        wnc2 = Map.get(win_map, p2, 0) * lnc1 * count
        p2sm = Map.get(lose_map, p2, %{})
        lnc2 = 27 - Map.get(win_map, p2, 0)
        p2s = Map.keys(p2sm)
        if p2s == [] do
          {%{}, {0, wnc2}}
        else
          new_games = for p1 <- p1s do
            for p2 <- p2s do
              {{p1, p2}, lnc1 * lnc2}
            end
          end |> List.flatten()
          |> Enum.group_by(fn {k, v} -> k end)
          |> Enum.map(fn {k,v}->
            {
              k,
              v
              |>Enum.map(fn {k, v} -> v end)
              |>Enum.sum()
            }
          end)
          |> Enum.into(%{})
          # |>log(:new_games)
          {new_games, {wnc1, wnc2}}
        end
      end
    end)
    |> Enum.reduce({%{}, {0, 0}}, fn {igmap, {ic1, ic2}}, {gmap, {c1, c2}} ->
      gmap = Map.merge(
        gmap,
        igmap,
        fn _, v1, v2 -> v1+v2 end
      )
      c1 = c1+ic1
      c2 = c2+ic2
      {gmap, {c1, c2}}
    end)
    
    # {ngmap, {nc1+c1, nc2+c2}} |> log(:show)
    round(ngmap, {nc1+c1, nc2+c2}, n-1, win_map, lose_map)
  end

  def exec() do
    start1 = 4
    start2 = 8

    # start1 = 1
    # start2 = 5

    {win_map,lose_map} = win_map(21)
                         # |>log()
    # rrplay([{{start1,0},{start2,0}}],{0,0},win_map, lose_map)

    # rrplay(%{
    #   {{start1,0},{start2,0}} => 1
    # },{0,0},win_map, lose_map)
    # |> log(:rrplay)
    # |>length()|>log()

    # round(
    #  %{{{start1,0},{start2,0}} => 1},
    #   {0, 0},
    #   100,
    #   win_map,
    #   lose_map
    # )
    # |> log(:round)
    :ok
  end
end
