IO.puts("Output")

# "Yes or No\n" |> IO.gets |> IO.puts

{:ok, file} = File.open("ch12_hello", [:write])

IO.binwrite(file, "some text")

File.close(file)

File.read("ch12_hello") |> IO.inspect

Path.join("foo", "bar") |> IO.puts

Path.expand("~/where") |> IO.puts

pid = spawn fn ->
  receive do: (msg -> IO.inspect msg)
end

# IO.write(pid, "Hello")

Process.alive?(pid) |> IO.puts

['hello', ?\s, "-world"] |> IO.puts

'hello' |> IO.puts

