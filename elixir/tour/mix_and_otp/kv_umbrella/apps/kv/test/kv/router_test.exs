defmodule KV.RouterTest do
  @local "lxy-mbp"
  # use ExUnit.Case, async: true

  use ExUnit.Case

  setup_all do
    current = Application.get_env(:kv, :routing_table)
    Application.put_env(:kv, :routing_table, [
      {?a..?m, :"foo@#{@local}"},
      {?n..?z, :"bar@#{@local}"}
    ])
    # 测试结束前，恢复环境配置
    on_exit fn -> Application.put_env(:kv, :routing_table, current) end
  end

  @tag :distributed
  test "route requests across nodes" do
    assert KV.Router.route("hello", Kernel, :node, []) == :"foo@#{@local}"
    assert KV.Router.route("world", Kernel, :node, []) == :"bar@#{@local}"
  end

  test "raises on unknown entries" do
    assert_raise RuntimeError, ~r/could not find entry/, fn ->
      KV.Router.route(<<0>>, Kernel, :node, [])
    end
  end
end
