defmodule Hello do
  def parse_input() do
    ~s([[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]])
    ~s([[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
[7,[[[3,7],[4,3]],[[6,3],[8,8]]]])
    |> String.split(~r{\n}, trim: true)
    |> Enum.map(&(String.trim(&1) |> Code.eval_string() |> elem(0)))
  end

  def explode([[lv, rv], second]) when not is_list(second) do
    {lv, [0, rv + second], 0}
  end

  def explode([first, [lv, rv]]) when not is_list(first) do
    {0, [first + lv, 0], rv}
  end

  def explode([[llv, lrv], second]) do
    [[llv, lrv], second] |> log(:explode_add)
    {llv, [0, add(lrv, second)], 0}
  end

  def explode([first, second]) do
    {first, 0, second}
  end

  def split(item) do
    result = item / 2
    [floor(result), ceil(result)]
  end

  def tranverse(item, lvl \\ 0, extra \\ {false, false})

  def tranverse(item, lvl, {false, actions}) when is_list(item) and lvl > 4 do
    lvl |> log(:explode_lvl)
    item |> log(:explode)
    {lv, item, rv} = explode(item)
    {{lv, item, rv}, {true, actions}}
  end

  def tranverse(item, _, {true, actions}) do
    {{0, item, 0}, {true, actions}}
  end

  def tranverse([lh, rh], lvl, {exploded, actions}) do
    # log(lvl)
    lvl = lvl + 1
    {{lhl, lh, lhr}, {exploded, actions}} = tranverse(lh, lvl, {exploded, actions})
    {{rhl, rh, rhr}, {exploded, actions}} = tranverse(rh, lvl, {exploded, actions})
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
    {{lhl, [lh, rh], rhr}, {exploded, actions}}
  end

  def tranverse(item, _, {exploded, actions}) do
    cond do
      item > 9 ->
        item |> log(:split)
        {{0, split(item), 0}, {true, actions}}
      true ->
        {{0, item, 0}, {exploded, actions}}
    end
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

  def loop(number) do
    {{_, number, _}, {has_action, actions}} = tranverse(number, 1)
                                              |> log(:number)
    if has_action do
      loop(number)
      # number
    else
      number
    end
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
          |> loop()
      end
    end)
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
end

# process ? state ?

 [
    [[[4, 0], [5, 4]], [[7, 7], [6, 0]]],
    [14, [[[3, 7], [4, 3]], [[6, 3], [8, 8]]]]
  ]
|> Hello.loop()
# Hello.exec()
|> Hello.log()

