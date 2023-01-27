defmodule Tour do
  defprotocol Utility do
    @spec type(t) :: String.t()
    def type(value)
  end

  defimpl Utility, for: BitString do
    def type(_value), do: "string"
  end

  defimpl Utility, for: Integer do
    def type(_value), do: "integer"
  end

  defprotocol Size do
    @doc "Calculates the size (not length) of a data structure"
    def size(data)
  end

  defimpl Size, for: BitString do
    def size(string), do: byte_size(string)
  end

  defimpl Size, for: Map do
    def size(map), do: map_size(map)
  end

  defimpl Size, for: Tuple do
    def size(tuple), do: tuple_size(tuple)
  end

  defimpl Size, for: MapSet do
    def size(set), do: MapSet.size(set)
  end

  defimpl Size, for: Any do
    def size(_), do: 2000
  end

  defprotocol NewSize do
    @fallback_to_any true
    def size(data)
  end

  defimpl NewSize, for: Any do
    def size(_), do: 7788
  end

  defmodule User do
    defstruct [:name, :age]
  end

  defmodule Movie do
    @derive [Size]
    defstruct [:time, :where]
  end

  defmodule City do
    defstruct [:location, :name]
  end

  defimpl Size, for: User do
    def size(_), do: 3
  end

  def run do

    Utility.type("fooo") |> IO.puts

    Size.size(%{label: "normal"}) |> IO.puts

    # (Protocol.UndefinedError) protocol Size not implemented for [1, 2, 3] of type List
    # Size.size([1,2,3]) |> IO.puts

    MapSet.new |> Size.size |> IO.puts

    %User{} |> Size.size |> IO.puts

    %Movie{} |>  Size.size |> IO.puts

    %Movie{} |>  NewSize.size |> IO.puts

    %City{} |> NewSize.size |> IO.puts
  end
end

Tour.run
