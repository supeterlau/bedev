defmodule KVServer do
  require Logger

  # @compile {:nowarn_unused_function, [
  #   serve_ch8: 1,
  #   serve_ch9_no_with: 1,
  #   write_line_ch8: 2
  # ]}

  # @compile :nowarn_unused_function

  @moduledoc """
  Documentation for `KVServer`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> KVServer.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  :binary 以 binaries 形式而非 lists 接收数据
  packet: :line 按行接收数据
  active: false 阻塞 :gen_tcp.recv/2 直到有数据
  reuseaddr: true 允许崩溃后重用端口
  """
  def accept(port) do
    {:ok, socket} = :gen_tcp.listen(
      port,
      [:binary, packet: :line, active: false, reuseaddr: true]
    )
    Logger.info("Accepting connections on port #{port}")
    loop_acceptor(socket)
  end

  defp loop_acceptor(socket) do
    {:ok, client} = :gen_tcp.accept(socket)
    # serve(client)

    # 处理多个请求 
    # Task.start_link(fn -> serve(client) end)

    # 用 supervisor 启动 task
    {:ok, server_pid} = Task.Supervisor.start_child(
      KVServer.TaskSupervisor,
      fn -> serve(client) end
    )

    #  KVServer.TaskSupervisor 不是模块而是原子
    # {:ok, server_pid} = KVServer.TaskSupervisor.start_child(
    #   fn -> serve(client) end
    # )
    # :ok = :gen_tcp.controlling_process(client, server_pid)
    :gen_tcp.controlling_process(client, server_pid) |> IO.inspect(label: "controlling_process")
    loop_acceptor(socket)
  end

  defp serve(socket) do
    msg = 
      with {:ok, data} <- read_line(socket),
           {:ok, command} <- KVServer.Command.parse(data),
           do: KVServer.Command.run(command)
           #   do
           #     ...
           # end
    write_line(socket, msg)
    serve(socket)
  end

  @doc deprecated: "Use serve"
  def _serve_ch9_no_with(socket) do
    msg = case read_line(socket) do
      {:ok, data} ->
        case KVServer.Command.parse(data) do
          {:ok, command} -> KVServer.Command.run(command)
          {:error, _} = err -> err
        end
      {:error, _} = err -> err
    end
    write_line(socket, msg)
    serve(socket)
  end

  @doc deprecated: "Use serve"
  def _serve_ch8(socket) do
    socket
    |> read_line
    |> write_line(socket)

    serve(socket)
  end

  defp read_line(socket) do
    # read from socket; receives data from socket
    # {:ok, data} = :gen_tcp.recv(socket, 0)
    # data
    :gen_tcp.recv(socket, 0)
  end

  defp write_line(socket, {:ok, text}) do
    :gen_tcp.send(socket, text)
  end

  defp write_line(socket, {:error, :unknown_command}) do
    :gen_tcp.send(socket, "UNKNOWN COMMAND\r\n")
  end

  defp write_line(_socket, {:error, :closed}) do
    # connection was closed, exit politely
    exit(:shutdown)
  end

  defp write_line(socket, {:error, :not_found}) do
    :gen_tcp.send(socket, "NOT FOUND\r\n")
  end
  
  defp write_line(socket, {:error, error}) do
    # Unknown error; write to client and exit
    :gen_tcp.send(socket, "ERROR\r\n")
    exit(error)
  end

  @doc deprecated: "Use write_line"
  def _write_line_ch8(line, socket) do
    # write to socket
    :gen_tcp.send(socket, line)
  end
end
