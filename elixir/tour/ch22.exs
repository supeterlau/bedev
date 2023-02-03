"Ø" |> String.to_charlist |> IO.inspect
"Ø" |> :binary.bin_to_list |> IO.inspect

:io.format("Pi is ~10.3f~n", [:math.pi])
:io.format("show map ~w~n", [%{a: 1, b: 3, c: 9}])

:io_lib.format("Pi is ~10.6f~n", [:math.pi]) |> to_string |> IO.puts

Base.encode16(:crypto.hash(:sha256, "Elixir")) |> IO.puts
# Base.encode16(:crypto.hash(:sha128, "Elixir")) |> IO.puts

digraph = :digraph.new
vertices = [{0.0,0.0},{1.0,0.0},{1.0,1.0}]
[v0, v1, v2] = (for v <- vertices, do: :digraph.add_vertex(digraph, v))
:digraph.add_edge(digraph, v0, v1)
:digraph.add_edge(digraph, v1, v2)
:digraph.get_short_path(digraph, v0, v2) |> IO.inspect

# table = :ets.new(:ets_ch22, [])
# 存入 tuple {name, population}
# :ets.insert(table, {"China", 1_400_000_000})
# :ets.insert(table, {"India", 1_300_000_000})
# :ets.insert(table, {"USA", 300_000_000})
# :ets.i(table) |> IO.inspect(label: "ets_table")

angle_45_deg = :math.pi * 45.0 / 180.0
:math.sin(angle_45_deg) |> IO.puts
:math.exp(55.0) |> IO.puts
:math.log(:math.exp(55.0)) |> IO.puts


q = :queue.new
q = :queue.in("A", q)
q = :queue.in("B", q)
{value, q} = :queue.out(q)
value |> IO.inspect(label: "First out")
q |> IO.inspect
{_value, q} = :queue.out(q)
{value, _q} = :queue.out(q)
value |> IO.inspect



song = """
iex> q = :queue.new
iex> q = :queue.in("A", q)
iex> q = :queue.in("B", q)
iex> {value, q} = :queue.out(q)
iex> value
{:value, "A"}
iex> {value, q} = :queue.out(q)
iex> value
{:value, "B"}
iex> {value, q} = :queue.out(q)
iex> value
:empty
"""

compressed = :zlib.compress(song)
(byte_size song) |> IO.puts
(byte_size compressed) |> IO.puts
:zlib.uncompress(compressed) |> IO.puts

