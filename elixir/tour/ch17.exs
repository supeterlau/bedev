dirs = ['.', '..']
for dir <- dirs,
    file <- File.ls!(dir),
    path = Path.join(dir, file) do
  path
    # File.regular?(path) do
  # File.stat!(path).size
end |> IO.inspect

for i <- [:a, :b, :c], j <- 1..3, do: {i, j} |> IO.inspect

pixels = <<213, 45, 132, 64, 76, 32, 76, 0, 0, 234, 32, 15>>

for <<r::8, g::8, b::8 <- pixels>>, i <- [:a, :b, :c], do: {{r, g, b}, i} |> IO.inspect

IO.puts("\nupcased version of whatever is typed")

stream = IO.stream(:stdio, :line)
for line <- stream, into: stream do
  String.upcase(line) <> "\n"
end
