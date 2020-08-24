map = %{}

map |> Map.get(:noop) |> IO.inspect

Map.put(map, :new_key, "new value") |> IO.inspect

Map.pop(map, :new_key) |> IO.inspect
