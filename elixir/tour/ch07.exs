list = [{:ok, 100}, {:error, 101}]
list |> IO.inspect

(list == [ok: 100, error: 101]) |> IO.puts

(list ++ [running: 102]) |> IO.inspect

([ok: 99] ++ list) |> IO.inspect

([ok: 99] ++ list)[:ok] |> IO.inspect

# Map

map = %{:a => 1, 2 => :b}
map |> IO.inspect

n = 2
map[n] |> IO.puts
# map[1] = :c
# map |> IO.inspect

Map.get(map, :a) |> IO.puts

Map.put(map, :c, 3) |> IO.inspect
map |> IO.inspect

Map.to_list(map) |> IO.inspect

map = %{:a => "one", :b => "two"}
(map == %{a: "one", b: "two"}) |> IO.puts

map.a |> IO.puts

# Nested data structures

users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

users |> IO.inspect

users[:john].age |> IO.puts

(put_in users[:john].age, 31) |> IO.inspect

(update_in users[:mary].languages, fn lang -> List.delete(lang, "Clojure") end) |> IO.inspect
