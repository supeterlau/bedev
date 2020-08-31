defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  # setup do
  #   registry = start_supervised!(KV.Registry)
  #   %{registry: registry}
  # end

  setup context do
    # 每个测试名字都是 unique 的，context.test 可以用作 registry 名字
    _ = start_supervised!({KV.Registry, name: context.test})
    %{registry: context.test}
  end

  test "spawns buckets", %{registry: registry} do
    assert KV.Registry.lookup(registry, "shopping") == :error

    KV.Registry.create(registry, "shopping")
    # assert + 赋值
    assert {:ok, bucket } = KV.Registry.lookup(registry, "shopping") 

    KV.Bucket.put(bucket, "milk", 100)
    assert KV.Bucket.get(bucket, "milk") == 100
  end

  test "removes bucket on exit", %{registry: registry} do
    KV.Registry.create(registry, "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

    # :normal
    Agent.stop(bucket) 

    # ensure registry processed (Agent.stop(bucket) 中的 :DOWN 消息)
    _ = KV.Registry.create(registry, "bogus")

    assert KV.Registry.lookup(registry, "shopping") == :error
  end

  test "removes bucket on crash", %{registry: registry} do
    KV.Registry.create(registry, "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

    # crash: stop process with non-normal reason (not :normal)
    Agent.stop(bucket, :shutdown)

    _ = KV.Registry.create(registry, "bogus")
    assert KV.Registry.lookup(registry, "shopping") == :error
  end

  test "bucket crash any time", %{registry: registry} do
    KV.Registry.create(registry, "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

    Agent.stop(bucket, :shutdown)

    # 调用 dead process 引发 :noproc exit (exit 是三类错误之一)
    catch_exit KV.Bucket.put(bucket, "milk", 3)
  end
end
