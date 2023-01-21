Enum.map([1,4,6], fn x -> x * 3 end) |> IO.inspect

Enum.map(%{1=>4, 6=>10}, fn {k, v} -> k * v end) |> IO.inspect

# ranges

Enum.map(1..3, fn x -> x * 4 end) |> IO.inspect

# 1..3 -> 1,2,3

1..3 |> IO.inspect

Enum.reduce(1..10, 1, &+/2) |> IO.inspect

odd? = &(rem(&1, 2) != 0)

1..100_000 |> Stream.map(&(&1 * 3)) |> Stream.filter(odd?) |> Enum.sum |> IO.puts

# Stream.cycle([1,2,3]) |> Enum.map(&(&1*2)) |> Enum.take(10) |> IO.inspect
Stream.cycle([1,2,3]) |> Stream.map(&(&1*2)) |> Enum.take(10) |> IO.inspect

"hello" |> String.next_codepoint |> IO.inspect

stream = File.stream!("./10.exs")
Enum.take(stream, 10) |> IO.inspect

