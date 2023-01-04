defmodule Ch02.MathTest do
  use Ch02.Assertion

  test "integers can be added and substracted" do
    assert 1+1 == 2
    assert 2+2 == 4
    assert 3-1 == 3
  end

  test "integers can be multiplied and divided" do
    assert 5 * 5 == 25
    assert 20 / 4 == 5
  end
end
