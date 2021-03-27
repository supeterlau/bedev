#! /usr/bin/env elixir

defmodule Main do
  def run() do
    File.stream!("input.txt")
    |> Stream.map(&(&1 <> "\n>>>\n\n"))
    # 全部载入到内存
    |> Enum.to_list()
    |> Stream.into(File.stream!("input.txt"))
    |> Stream.run()
  end
end

Main.run()
