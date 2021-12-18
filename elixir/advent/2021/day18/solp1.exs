defmodule Hello do
  def parse_input() do
     File.read!('./input.txt')
#     ~s([[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
# [[[5,[2,8]],4],[5,[[9,9],0]]]
# [6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
# [[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
# [[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
# [[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
# [[[[5,4],[7,7]],8],[[8,3],8]]
# [[9,3],[[9,9],[6,[4,9]]]]
# [[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
# [[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]])
#     ~s([[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
#       [7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
#       [[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
# [[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
# [7,[5,[[3,8],[1,4]]]]
#       [[2,[2,2]],[8,[8,1]]]
# [2,9]
# [1,[[[9,3],9],[[9,0],[0,7]]]]
#       [[[5,[7,4]],7],1]
#     [[[[4,2],2],6],[8,7]])
#     ~s([1,1]
# [2,2]
# [3,3]
# [4,4]
# [5,5]
# [6,6])
    |> String.split(~r{\n}, trim: true)
    |> Enum.reject(&is_nil(&1))
    |> Enum.map(&(String.trim(&1) |> Code.eval_string() |> elem(0)))
  end

  def explode([[lv, rv], second]) when not is_list(second) do
    {lv, [0, rv + second], 0}
  end

  def explode([first, [lv, rv]]) when not is_list(first) do
    {0, [first + lv, 0], rv}
  end

  def explode([[llv, lrv], second]) do
    {llv, [0, add(lrv, second)], 0}
  end

  def explode([first, second]) do
    {first, 0, second}
  end

  def do_explode(pair, lvl, done \\ false)

  def do_explode(pair, _, true), do: {{0, pair, 0}, true}

  def do_explode([lh, rh], lvl, _) when lvl > 4 do
    {explode([lh, rh]), true}
  end

  def do_explode([lh, rh], lvl, done) do
    lvl = lvl + 1
    {{lhl, lh, lhr}, done} = do_explode(lh, lvl, done)
    {{rhl, rh, rhr}, done}= do_explode(rh, lvl, done)
    lh =
      cond do
        is_list(lh) ->
          add(lh, rhl)
        true ->
          lh + rhl
      end
    rh =
      cond do
        is_list(rh) ->
          add(lhr, rh)
        true ->
          rh + lhr
      end
    {{lhl, [lh, rh], rhr}, done}
  end

  def do_explode(value, _, done) do
    { {0, value, 0}, done }
  end

  def do_split(item, lvl, cont \\ :cont, done \\ false)

  def do_split(item, _, cont, true), do: {cont, item, true}
  
  def do_split(item, _, :explode, done) do
    {:explode, item, done}
  end

  def do_split([lh, rh], lvl, cont, done) do
    lvl = lvl + 1
    {cont, lh, done} = do_split(lh, lvl, cont,  done)
    if cont == :explode do
      {:explode, [lh, rh], done}
    else
      {cont, rh, done} = do_split(rh, lvl, cont, done)
      {cont, [lh, rh], done}
    end
  end

  def do_split(value, lvl, _, _) do
    if value > 9  do
      result = value / 2
      if lvl >= 4 do
        {:explode, [floor(result), ceil(result)], true}
      else
        {:cont, [floor(result), ceil(result)], true}
      end
    else
      {:cont, value, false}
    end
  end

  def loop_explode(number) do
    {{_, number,_ }, done}= do_explode(number, 1)
    if done do
      loop_explode(number)
    else
      number
    end
  end

  def loop_split(number) do
    {cont, number, done} = do_split(number, 1)
    if done do
      if cont == :explode do
        tranverse(number)
      else
        loop_split(number)
      end
    else
      number
    end
  end

  def tranverse(number) do
    number
    |> loop_explode()
    |> loop_split()
  end

  def exec() do
    parse_input()
    |> Enum.reduce([], fn value, acc ->
      case acc do
        [] ->
          value
        acc ->
          [acc, value]
          |> log()
          |> tranverse()
      end
    end)
    |> cal()
  end

  def cal([lh, rh]) do
    3 * cal(lh) + 2 * cal(rh)
  end

  def cal(value), do: value

  def log(item, label) do
    IO.inspect(item, charlists: :list, label: label)
  end

  def log(item) do
    IO.inspect(item, charlists: :list)
  end

  def add([lh, rh], value) do
    if is_list(rh) do
      [lh, add(rh, value)]
    else
      [lh, rh + value]
    end
  end

  def add(value, [lh, rh]) do
    if is_list(lh) do
      [add(value, lh), rh]
    else
      [lh + value, rh]
    end
  end
end

Hello.exec()
|> Hello.log()
