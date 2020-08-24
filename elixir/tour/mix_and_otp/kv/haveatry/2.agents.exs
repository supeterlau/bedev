{:ok, agent} = Agent.start_link fn -> [] end

agent |> IO.inspect

Agent.update(agent, fn list -> ["eggs" | list] end)

Agent.get(agent, fn list -> list end) |> IO.inspect

agent |> Process.alive? |> IO.puts

Agent.stop(agent)

agent |> Process.alive? |> IO.puts

{:ok, agent} = Agent.start_link fn -> [] end

Agent.get(agent, fn list -> list end) |> IO.inspect

Agent.update(agent, fn _list -> 123 end)

Agent.get(agent, fn list -> list end) |> IO.inspect

Agent.update(agent, fn content -> %{a: content} end)

Agent.get(agent, fn list -> list end) |> IO.inspect

Agent.update(agent, fn content -> [12 | [content]] end)

Agent.get(agent, fn list -> list end) |> IO.inspect

Agent.update(agent, fn list -> [:nop | list] end)

Agent.get(agent, fn list -> list end) |> IO.inspect
