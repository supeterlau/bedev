defmodule Tour do

  def call_fun(a, b, c) do
    IO.inspect binding()
    require IEx; IEx.pry
    a * b * c
  end

  def run do

    (1..10)
    |> IO.inspect(label: "before")
    |> Enum.map(fn x -> x * x end)
    |> IO.inspect
    |> Enum.sum
    |> IO.inspect(label: "end")

    call_fun(3,4,55)
  end
end

Tour.run
