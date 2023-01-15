ascii = fn
  v when is_integer(v) -> [v] |> List.to_string()
  v when is_list(v) -> v |> hd()
end

ascii.('a')
|>IO.inspect()
