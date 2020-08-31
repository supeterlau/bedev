defmodule KV.Router do
  @local "lxy-mbp"

  @doc """
  Dispatch `mod`, `fun`, `args` request to the appropriate node

  Based on `bucket`
  """
  def route(bucket, mod, fun, args) do
    # 获取 binary 第一个 byte
    first = :binary.first(bucket)

    # 在 table() 中找到 entry 或抛出错误
    entry = 
      Enum.find(table(), fn {enum, _node} ->
        first in enum
      end) || no_entry_error(bucket)

    if elem(entry, 1) == node() do
      # 本 node 上执行
      apply(mod, fun, args)
    else
      # 其他 node 上执行
      {KV.RouterTasks, elem(entry, 1)}
      |> Task.Supervisor.async(KV.Router, :route, [bucket, mod, fun, args])
      |> Task.await
    end
  end

  defp no_entry_error(bucket) do
    raise "could not find entry for #{inspect bucket} in table #{inspect table()}"
  end

  @doc """
  routing table
  """
  def table do
    [
      {?a..?m, :"foo@#{@local}"},
      {?n..?z, :"bar@#{@local}"}
    ]
  end
end
