loop = fn count, fun -> 
  {to, msg} = receive do
    {command, to} ->
      cond do
        command in [:incr, :INCR, INCR] -> 
          {to, {:ok, count + 1}}
        command in [:decr, :DECR, DECR] ->
          {to, {:ok, count - 1}}
        command == :done -> 
          {to, {:done, count}}
        command == :oops0 -> raise "oops"
        command == :oops -> exit(:oops)
        true ->
          {to, {:error, count, "Unknown Command #{inspect command}"}}
      end
    _ -> {self(), {:error, count}}
  end
  if to != self(), do: send(to, {:counter, msg})
  {state, count} = case msg do
    {state, count, _} -> {state, count}
    {state, count} -> {state, count}
  end
  if state != :done, do: fun.(count, fun)
end

# child = spawn_link(fn -> loop.(10, loop) end)

start_child = fn count ->
  # with child = spawn_link(fn -> loop.(count, loop) end) do
  with child = spawn(fn -> loop.(count, loop) end) do
    IO.puts("#{inspect self()}")
    {child, Process.monitor(child)}
  end
end

recv = fn -> receive do
    {:counter, {:ok, count}} -> count
    {:counter, {:error, count, msg}} -> 
      IO.inspect(msg, label: "Error")
      count
    {:counter, {:done, count}} -> 
      IO.inspect("Normal Exit", label: "Done")
      count
    info -> IO.inspect(info)
  after
    1_000 -> "nothing after 1s"
  end
end

# {child, start_child, recv}
# {_, funcs} = Code.eval_file(path)
# [loop, recv, start_child] = funcs |> Keyword.values()
# {child, ref} = start_child.(10)
# send(child, {:oops, self()})
# recv.()
