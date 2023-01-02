defmodule Ch02.MathTest do
  require Ch02.ModuleCustom
  Ch02.ModuleCustom.extend

  import Ch02.Assertion
  use Ch02.Assertion
  # fake_use Ch02.Assertion

  def run01 do
    assert 5 == 5
    assert 10 > 0
    assert 1 > 2
    assert 10 * 10 == 100
  end
end
