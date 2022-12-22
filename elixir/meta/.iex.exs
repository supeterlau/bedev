load_file = fn (key, subkey) -> 
  get_dir = fn key -> File.ls!() |> Enum.filter(& String.ends_with?(&1, Integer.to_string(key))) |> hd() end

  get_sub = fn (key, files) -> files |> Enum.filter(& String.starts_with?(&1, Integer.to_string(key) |> String.pad_leading(2, "0"))) |> hd() end

  get_files = fn (key, subkey) ->
    with dir <- get_dir.(key),
      files <- File.ls!(dir),
      sub <- get_sub.(subkey, files) do
        Path.join(dir, sub)
    end
  end
  get_files.(key, subkey) |> c() 
end

# load_file.(2,2)
