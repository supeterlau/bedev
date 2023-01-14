case :filename.join([:code.root_dir(), "releases", :erlang.system_info(:otp_release), "OTP_VERSION"]) |> :file.read_file() do
  {:ok, version} -> version
  _ -> "error"
end

|> IO.puts()
