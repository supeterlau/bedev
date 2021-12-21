defmodule Advent.DayTest do
  use ExUnit.Case

  alias Advent.Day

  test "parse input" do
    assert Day.parse_input() |> hd() |> String.valid?()
  end

  test "exec" do
    assert Day.exec() == :ok
  end

  test "cal_form" do
    # assert true
    # [algo, target] = Day.parse_input()
    # {target, rows, cols} = Day.extend_pixel(target)

    # Map.get(target, {0,2}) |> Day.log(:before)
    # assert Map.get(target, {0,2}) == "0"

    # {target, rows, cols} = Day.enhance(target, rows, cols, algo, 1)

    # Map.get(target, {0,2}) |> Day.log(:after)
    # assert Map.get(target, {0,2}) == "1"
    # 
    # Map.get(target, {2,4}) |> Day.log(:after)
    # assert Map.get(target, {2,4}) == "1"

    # for y <- 0..5 do
    #   for x <- 0..5 do
    #     Map.get(target, {x,y})
    #   end |> Enum.join()
    # end
    # target|>Day.print(rows, cols)
    # assert Day.cal_form({0,0},target, algo) == "1"
    # assert Day.cal_form({-1,-1},target, algo) == "1"
  end
end

