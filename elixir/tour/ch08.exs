String.length("Erlang") |> IO.puts

defmodule Math do
  def sum(a, b) do
    # a+b
    run_sum(a, b)
  end

  defp run_sum(a, b) do
    a+b
  end

  def zero?(0) do
    true
  end

  def zero?(x) when is_integer(x) do
    false
  end

  def zero?(_) do
    IO.puts "not an integer"
    false
  end
end

(Math.sum 3, 5) |> IO.puts
# (Math.run_sum 3, 5) |> IO.puts

(Math.zero? 0) |> IO.puts
(Math.zero? 1) |> IO.puts
(Math.zero? [1,2,3]) |> IO.puts
(Math.zero? (0.0)) |> IO.puts

fun = &Math.zero?/1
fun.(0) |> IO.puts

fun = &(&1 + 1)
fun.(100) |> IO.puts

fun = &"Erlang #{&1}"
fun.("Clojure") |> IO.puts

fun = &List.flatten(&1, &2)
fun.([1, [[2],3]], [4, [6]]) |> IO.inspect

fun = &List.flatten/2
fun.([1, [[2],3]], [4, [6]]) |> IO.inspect

defmodule Concat do

  def join(a, b) when a != 'a' do
    a <> " --- " <> b
  end

  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end

  # def join(a, b, _sep) when is_nil(b) do
  #   a
  # end

end

IO.puts Concat.join("a", "Servo")
IO.puts Concat.join("Rust", "Servo")
IO.puts Concat.join("Rust", "Servo", "---")
