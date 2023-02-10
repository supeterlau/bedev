defmodule DemoServerTest do
  use ExUnit.Case
  doctest DemoServer

  test "greets the world" do
    assert DemoServer.hello() == :world
  end
end
