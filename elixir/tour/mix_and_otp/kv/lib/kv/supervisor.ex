defmodule KV.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  # use Supervisor, 引入 @behaviour Supervisor
  @impl true
  def init(:ok) do
    children = [
      # 启动 child {:ok, bucket_pid} = DynamicSupervisor.start_child(KV.BucketSupervisor, KV.Bucket) start_child(supervisor 名, child spec)
      # 创建名为 KV.BucketSupervisor 的 DynamicSupervisor
      # 注意并没有给被启动的 bucket 命名
      {DynamicSupervisor, name: KV.BucketSupervisor, strategy: :one_for_one},
      # KV.Registry
      {KV.Registry, name: KV.Registry},
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
