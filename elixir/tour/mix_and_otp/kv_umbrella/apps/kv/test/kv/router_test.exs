defmodule KV.RouterTest do
  @local "lxy-mbp"
  use ExUnit.Case, async: true

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
