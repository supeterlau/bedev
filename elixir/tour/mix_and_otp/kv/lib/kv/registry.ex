defmodule KV.Registry do
  use GenServer

  ## Client API

  @doc """
  Starts registry with the given options (:name)

  `:name` : required
  """
  def start_link(opts) do
    server = Keyword.fetch!(opts, :name)
    GenServer.start_link(__MODULE__, server, opts)
  end

  @doc """
  Looks up bucket pid for `name` in `server`

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def lookup(server, name) do
    # GenServer.call(server, {:lookup, name})
    # lookup 直接 lookup ETS  no server access
    case :ets.lookup(server, name) do
      [{^name, pid}] -> {:ok, pid}
      [] -> :error
    end
  end

  @doc """
  Create Bucket

  Ensure there is a bucket associated with the given `name` in `server`
  """
  def create(server, name) do
    # GenServer.cast(server, request)
    # GenServer.cast(server, {:create, name})
    
    # GenServer.call(server, request, timeout \\ 5000)
    GenServer.call(server, {:create, name})
  end
  
  ## Server API (GenServer Callbacks)

  @impl true
  def init(table) do
    # start_link :name => table
    # names = %{}
    # names map to ETS table
    names = :ets.new(table, [:named_table, read_concurrency: true])
    refs = %{}
    {:ok, {names, refs}}
  end

  @doc """
  Find process by name from names (useless, can be deleted)
  """
  def handle_call_removed({:lookup, name}, _from, state) do
    {names, _} = state
    {:reply, Map.fetch(names, name), state}
  end

  @doc """
  Create a process with name
    
  check if name exists, if not exists, create new process and put in names
  """
  @impl true
  def handle_call({:create, name}, _from, {names, refs}) do
    # 调用 client API 中的 lookup
    case lookup(names, name) do
      {:ok, _pid} ->
        # {:noreply, {names, refs}}
        {:reply, {names, refs}}
      :error ->
        {:ok, pid} = DynamicSupervisor.start_child(
          KV.BucketSupervisor,
          KV.Bucket
        )
        ref = Process.monitor(pid)
        refs = Map.put(refs, ref, name)
        :ets.insert(names, {name, pid})
        # {:noreply, {names, refs}}
        {:reply, pid, {names, refs}}
    end
  end

  def handle_cast_names_in_map({:create, name}, {names, refs}) do
    if Map.has_key?(names, name) do
      {:noreply, {names, refs}}
    else
      # KV.Registry 同时 link monitor bucket Processes
      # Link 是双向的，bucket 的崩溃会导致 registry 崩溃
      # {:ok, bucket} = KV.Bucket.start_link([])

      # start_child(supervisor, child_spec)
      # 使用 DynamicSupervisor 启动 bucket，获取 bucket pid
      {:ok, bucket} = DynamicSupervisor.start_child(KV.BucketSupervisor, KV.Bucket)

      # 建立 monitor
      ref = Process.monitor(bucket)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, bucket)
      {:noreply, {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    # 用 ref 找到 name, 删除 ref name, 根据 name 删除 pid
    # 根据 ref 删除 refs 中 %{ref => name}
    {name, refs} = Map.pop(refs, ref)
    # 根据 name 删除 names 中 %{name => pid}
    # names = Map.delete(names, name)
    :ets.delete(names, name)
    {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
