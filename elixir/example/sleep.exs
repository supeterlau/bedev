defmodule Test do
  def sleep_for do
    for i <- [1,2,3,4,5,6] do
      :timer.sleep(1000)
      IO.puts i
    end
  end

  def sleep_map do
    [1,2,3,4,5,6]
    |> Enum.map(fn elem -> 
      :timer.sleep(1000)
      IO.puts elem
      elem
    end)
  end
end

Test.sleep_for

Test.sleep_map
