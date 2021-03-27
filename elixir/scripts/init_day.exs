#! /usr/bin/env elixir


defmodule Main do

  def add_template(line) do
    template="
- TL
- Task
- Note
- Topic
- Link
- Repo
- MainPage
"
    if Regex.match?(~r/^# \[\[ SECTION BEGIN \]\].*/, line) do
      line <> template
    else
      line
    end 
    # |> IO.inspect()
  end

  def run do
    input=output=[System.get_env("HQ"), "Notes", "daily", "day.txt"] |> Path.join()
    # input=[System.get_env("HQ"), "Notes", "daily", "day.txt"] |> Path.join()
    # output=[System.get_env("HQ"), "Notes", "daily", "out_day.txt"] |> Path.join()
    File.stream!(input)
    |> Stream.map(&add_template(&1))
    |> Enum.to_list()
    |> Stream.into(File.stream!(output))
    |> Stream.run()
  end
end

Main.run()
