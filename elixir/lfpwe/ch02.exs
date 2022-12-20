defmodule Example do
  def run do
    greet = fn name -> "Hello, " <> name <> "!" end
    greet.("Ana")
    |> IO.inspect
    greet.("John")
    |> IO.inspect

    total_price = fn price, quantity -> price * quantity end
    total_price.(5, 6)
    |> IO.inspect
  end
end

Example.run
