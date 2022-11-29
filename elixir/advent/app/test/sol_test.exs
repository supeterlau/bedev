defmodule Advent.DayTest do
  use ExUnit.Case

  alias Advent.Day

  test "exec" do
    assert Day.exec() == :ok
  end
end
