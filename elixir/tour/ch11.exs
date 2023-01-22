pid = spawn fn -> 1 + 2 end

pid |> Process.alive? |> IO.puts

pid = self()

pid |> Process.alive? |> IO.puts

send self(), {:first, "Message"}
receive do
  {:first, msg} -> msg
  {:second, _msg} -> "not match"
end |> IO.puts

receive do
  {:wait, msg} -> msg
after
  1_000 -> "oh, time out"
end |> IO.puts

current = self()

spawn fn -> send(current, {:hello, self()}) end

receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end |> IO.puts

# 未 link 父进程无错误显示
spawn fn -> raise "oops" end

# linked 父进程有错误显示
# spawn_link fn -> raise "oops" end

Task.start fn -> raise "task oops" end

defmodule KV do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end


# Process.exit(self(), :normal)

