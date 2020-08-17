"hello" |> is_binary |> IO.puts

?a |> IO.puts

?ç |> IO.puts

?岛 |> IO.puts

# "\u0061" === "a"
(0x0061 == 97 == ?a) |> IO.puts

"hełło" |> String.length |> IO.puts
"hełło" |> byte_size |> IO.puts

# 显示 7 个 bytes

"hełło" <> <<0>> |> IO.inspect

"hełło" |> IO.inspect(binaries: :as_binaries)

(<<0::1, 1::1, 0::1, 1::1>> == <<5::4>>) |> IO.puts

(<<1::1, 0::1, 1::1>> == <<5::3>>) |> IO.puts

(<<1::8>> === <<257>>) |> IO.puts
(<<2, 255>> === <<257>>) |> IO.puts
(<<3, 4>> === <<4, 3>>) |> IO.puts

is_bitstring(<<3::4>>) |> IO.puts
is_binary(<<3::4>>) |> IO.puts

bit = <<42::16>>
[is_bitstring(bit), is_binary(bit)] |> IO.inspect

<<239, 191, 19>> |> String.valid? |> IO.puts

<<head, _rest::binary>> = "usa"
head |> IO.puts

cl1 = 'winter'
cl2 = ' coming'
cl1++cl2 |> IO.puts
