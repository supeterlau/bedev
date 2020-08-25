defmodule KV.Registry do
  use GenServer

  ## Client API

  @doc """
  Starts registry
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up bucket pid for `name` in `server`

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensure there is a bucket associated with the given `name` in `server`
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end
  
  ## Server API (GenServer Callbacks)

  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @doc """
  Find process by name from names
  """
  @impl true
  def handle_call({:lookup, name}, _from, state) do
    {names, _} = state
    {:reply, Map.fetch(names, name), state}
  end

  @doc """
  Create a process with name
    
  check if name exists, if not exists, create new process and put in names
  """
  @impl true
  def handle_cast({:create, name}, {names, refs}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, refs}}
    else
      {:ok, bucket} = KV.Bucket.start_link([])
      # 建立 monitor
      ref = Process.monitor(bucket)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, bucket)
      {:noreply, {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    # 根据 ref 删除 refs 中 %{ref => name}
    {name, refs} = Map.pop(refs, ref)
    # 根据 name 删除 names 中 %{name => pid}
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
