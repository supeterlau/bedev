defmodule App.Task do
  def yield() do
    tasks = 
      for i <- 1..10 do
        Task.async(fn ->
          Process.sleep(i * 1000)
          i
        end)
      end
    tasks_with_results = Task.yield_many(tasks, 5000)
    results = 
      Enum.map(tasks_with_results, fn {task, res} ->
        res || Task.shutdown(task, :brutal_kill)
      end)
    # {:ok, value} 
    # {:exit, _}   crashed tasks
    # nil          no replies
    for {:ok, value} <- results do
      IO.inspect(value)
    end
  end

  def process(data) do
    tasks = 
      for entry <- data do
        # if invalid_input?(entry) do
        #   Task.completed({:error, :invalid_input, entry})
        # else
        #   Task.async(fn -> next_process(entry) end)
        # end
        Task.async(fn -> next_process(entry) end)
      end
    Task.await_many(tasks)
  end

  def invalid_input?(entry), do:  rem(entry,3) == 0

  def next_process(entry) do
    Process.sleep(:random.uniform(5) * 1000)
    {:ok, :next_process, entry}
  end
end

# App.Task.process(1..20)
# |> IO.inspect()

App.Task.yield()
