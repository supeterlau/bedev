defmodule Advent.DayTest do
  use ExUnit.Case

  alias Advent.Day

  test "parse input" do
    # assert Day.parse_input() |> hd() |> String.valid?()
  end

  test "exec" do
    assert Day.exec() == :ok
  end

  test "take turn" do
    result = [6,6,6]
    assert Day.take_turn(2, result) == 10
  end

  test "move" do
    start = 7
    assert Day.move(2, start) == 9
    assert Day.move(5, start) == 2
  end

end

