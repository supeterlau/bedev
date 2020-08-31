defmodule KV do
  use Application

  @moduledoc """
  Documentation for `KV`.
  """

  @impl true
  def start(_type, _args) do
    # 配置自动启动 supervisor
    # Supervisor name 也可以用于 debug __MODULE__
    KV.Supervisor.start_link(name: KV.Supervisor)
  end

  @doc """
  Hello world.

  ## Examples

      iex> KV.hello()
      :world

  """
  def hello do
    :world
  end
end
