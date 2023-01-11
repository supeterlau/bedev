defmodule Sup.Delegate do
  defmacro __using__(mod: {_,_,[mod]}) do 
    mod |> IO.inspect()
    mod.__info__(:function)
    quote do
      defdelegate alive?(), to: Sup
    end
  end
end

defmodule Sup.Agent do
  use Sup.Delegate, mod: Agent
end

defmodule Sup do
  @sup_name Sup.DynamicSupervisor

  def init_sup() do
    unless alive?(@sup_name) do
      children = [
        {DynamicSupervisor, strategy: :one_for_one, name: @sup_name}
      ]
      Supervisor.start_link(children, strategy: :one_for_one)
    end
  end

  # 按需替换 registry
  # https://hexdocs.pm/elixir/Registry.html
  def alive?() do
    alive?(@sup_name)
  end

  def alive?(pname) do
    case Process.whereis(pname) do
      nil -> nil
      pid -> pid |> Process.alive?()
    end
  end

  def pname(), do: @sup_name

  def sup_agent(state) do
    init_sup()
    {:ok, agent} = DynamicSupervisor.start_child(@sup_name, {Agent, state})
    agent
  end
end
