defmodule Ch02.Run do
  import Ch02.Loop
  require Ch02.Debugger

  def fire04() do
  end

  def fire03() do
    # Application.put_env(:debugger, :log_level, :debug)
    remote_api_call = fn -> IO.puts("calling remote API ...") end
    Ch02.Debugger.log(remote_api_call.())
  end

  def fire02() do
    run_loop = spawn fn ->
      while true do
        receive do
          :stop ->
            IO.puts "Stoping ..."
            break()
          message ->
            IO.puts "Go #{inspect message}"
        end
      end
    end
    run_loop
  end
  
  def fire01() do
    run_loop = fn ->
      pid = spawn(fn -> :timer.sleep(4000) end)
      while Process.alive?(pid) do
        IO.puts "#{inspect :erlang.time()} Stayin' alive!"
        :timer.sleep 1000
      end
    end
    run_loop.()
  end
end
