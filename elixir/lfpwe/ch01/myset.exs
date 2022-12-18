defmodule Example do
  defmodule MySet do
    defstruct items: []

    def push(set = %{items: items}, item) do
      if Enum.member?(items, item) do
        set
      else
        %{set | items: items ++ [item]}
      end
    end
  end

  def run do
    set = %MySet{}
    set = MySet.push(set, "apple")

    new_set = %MySet{}
    new_set = MySet.push(new_set, "pie")

    IO.inspect MySet.push(set, "apple")

    IO.inspect MySet.push(new_set, "apple")

    ["dogs", "cats", "flowers"]
    |> Enum.map(&String.upcase/1)
    |> IO.inspect
  end
end

Example.run
