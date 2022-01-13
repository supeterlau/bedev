defmodule Tour do
  defmodule Language do
    defstruct name: "Golang", created_at: 2009
  end

  defmodule Product do
    @enforce_keys [:id]
    defstruct [:name, :id, intro: "Next generation product"]
  end

  def run do
    %Language{} |> IO.inspect
    %Language{name: "Rust"} |> IO.inspect
    # %Language{oops: :value} |> IO.inspect

    lang = %Language{name: "Java", created_at: 1995}
    lang.created_at |> IO.puts
    %Language{name: what} = lang
    what |> IO.puts
    %{lang | name: "Python", created_at: 1991}
    lang |> IO.inspect

    lang.__struct__ |> IO.puts

    (%{a: 1, b: 2} == %{b: 2, a: 1}) |> IO.puts

    %Product{id: 10000} |> IO.inspect
    %Product{id: [1,2,3,4]} |> IO.inspect
  end

end

Tour.run
