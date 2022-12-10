check = fn (string, acc, fun) ->
  case string do
    "" -> acc 
    "1" <> tail -> 
      acc = acc <> "1"
      fun.(tail, acc, fun)
    "0" <> tail -> 
      if acc == "" do
        fun.(tail, acc, fun)
      else
        fun.("", acc, fun)
      end
  end
end

"0110110" |> check.("", check) |> IO.inspect()
"0110110" |> check.("", check) |> IO.inspect()

