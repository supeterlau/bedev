defmodule Advent.Day do
   
  def parse_input() do
     # File.read!('./input1.txt') |> String.split(~r{\n}, trim: true)
     File.read!('./input.txt') |> String.split(~r{\n}, trim: true)
  end

  def exec() do
    [_, data] = parse_input()
    |> hd()
    |> String.split("area: ")
    [x1..x2, y1..y2] = data 
                     |> String.split(", ")
                     |> Enum.map(&Code.eval_string(&1) |> elem(0))
    yrange = cal_yrange({y1, y2})
             |> IO.inspect()
    xrange = cal_xrange({x1, x2})
             |> IO.inspect()
    range = {{x1,x2}, {y1, y2}}
    pairs =  pairxy(xrange, yrange)
             |>Enum.filter(&test(&1, {0,0}, range))
             |> Enum.uniq()
             |> Enum.count()
             # |> Enum.map(fn {_, y} -> y end)
             # |> Enum.max()
             # |> cal()
  end

  def cal_xrange({x1, x2}) do
    {
      ceil((:math.sqrt(8 * x1 + 1)-1)/2), 
      x2
      # floor(Enum.min([
      #   (:math.sqrt(8 * x2 + 1)-1)/2, 
      #   (x2+3) / 3
      # ]))
    }
  end

  def cal_yrange({y1, _y2}) do
    # {1, abs(y1)-1}
    {y1, abs(y1)-1}
  end

  def cal(y), do: div y * (y + 1) , 2

  def moveone({x, y}, {posx, posy}) do
    posx = posx+x
    posy = posy+y
    x = if x > 0, do: x - 1, else: 0
    y = y - 1
    {{x, y}, {posx, posy}}
  end

  def pairxy({x1, x2}, {y1, y2}) do
    for x <- x1..x2, y <- y1..y2 do
      {x, y}
    end
  end

  def test({x,y}, {posx, posy}, {{x1, x2}, {y1, y2}}=range) do
    cond do
      posx > x2 or posy < y1 -> 
        # :stop
        false
      (posx >= x1 and posx <= x2) and (posy >= y1 and posy <= y2) -> 
        # :inner
        true
      true -> 
        # :cont
        {{x, y}, {posx, posy}} = moveone({x, y}, {posx, posy})
        test({x,y},{posx, posy}, range)
    end
  end

  def get_values(values, step) do
    {low, high} = values 
    |> Enum.filter(fn {_, _, s} -> step == s end )
    |> Enum.map(fn {low, high, _} -> {ceil(low), floor(high)} end)
    |> hd()
    low..high
  end

  def move(_, {dxs, dys}, 0) when is_list(dxs) do
    {dxs, dys}
  end

  def move({x, y}, {dxs, dys}, n) when is_list(dxs) do
    {x, dxs} = movex(n, x, dxs)
    {y, dys} = movey(n, y, dys)
    move({x, y},{dxs, dys}, n-1)
  end

  def move({x, y}, {dx, dy}, n) do
    move({x, y}, {[dx], [dy]}, n)
  end

  def movex(_n, 0, xs) do
    {0, xs}
  end

  def movex(_n, x, xs) do
    lastx = hd(xs)
    {x-1, [lastx+x | xs]}
  end

  def movey(_n, y, ys) do
    lasty = hd(ys)
    {y-1, [lasty+y | ys]}
  end
end

Advent.Day.exec()
|> IO.inspect(charlists: :list)
