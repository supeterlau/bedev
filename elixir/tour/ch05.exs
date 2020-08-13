result = case {7, 8 , 9} do
  {x, 8, y} when x >= 10 ->
    IO.puts "#{x}, #{y}"
    x * y
  {x, 8, y} when x < 10 and y < 10 ->
    IO.puts "#{x}, #{y}"
    x * y * 10
  _ ->
    "match any value"
end

IO.puts result

f = fn
  x, y when x > 0 -> x + y
  x, y -> x * y
end

f.(1,9) |> IO.puts
f.(-1, 9) |> IO.puts

# def f(x, y) when x > 0 do: x + y
# def f(x, y) do: x * y

cond do
  2 + 2 == 5 ->
    IO.puts "not true"
  2 * 2 == 3 ->
    IO.puts "not true again"
  1 + 1 == 2 ->
    IO.puts "just true"
end

if true, do: "This works" |> IO.puts

if true do
  "works"
else
  "not seen it"
end

unless false, do: "seen it here" |> IO.puts

is_number(if true do
  1+2
end) |> IO.puts

is_number if true do
  1+2
end  |> IO.puts
