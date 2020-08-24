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
    {:ok, %{}}
  end

  @doc """
  Find process by name from names
  """
  @impl true
  def handle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  @doc """
  Create a process with name
    
  check if name exists, if not exists, create new process and put in names
  """
  @impl true
  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, bucket} = KV.Bucket.start_link([])
      {:noreply, Map.put(names, name, bucket)}
    end
  end
end
