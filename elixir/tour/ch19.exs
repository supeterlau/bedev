# :foo + 1 |> IO.puts

# raise "oops error info"

# raise ArgumentError, message: "invalid argument foo"

defmodule Tour do
  defmodule ChapterError do
    defexception message: "chapter error", run: :do_some_run
  end

  defmodule RunAfter do
    def omit_try do
      raise "no try"
    after
      IO.puts "cleaning up!"
    end
  end

  def run do
    # raise ChapterError, message: "use custom message"
    try do
      raise ChapterError, run: :retry
    rescue
      e in ChapterError -> 
        e.run |> IO.puts
        e |> IO.inspect
    end

    case File.read "unknown" do
      {:ok, body} -> IO.puts "Success: #{body}"
      {:error, reason} -> IO.puts "Error: #{reason}"
    end

    try do
      Enum.each -50..50, fn(x) ->
        if rem(x,13) == 0, do: throw(x)
      end
      "Got Nothing"
    catch
      x -> "Got #{x}"
    end |> IO.puts

    try do
      exit "Exiting"
    catch
      :exit, value -> "not really #{inspect value}"
    end |> IO.puts

    # RunAfter.omit_try

    x = 2
    try do
      1/x
    rescue
      ArithmeticError ->
        :infinity
    else
      y when y < 1 and y > -1 ->
        :small
      _ -> :large
    end |> IO.puts

    what_happened = 
      try do
        raise "fail"
        :did_not_raise
      rescue
        _ -> :rescued
      end
      what_happened |> IO.puts
  end
end

Tour.run
