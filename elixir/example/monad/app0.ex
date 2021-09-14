# https://shane.logsdon.io/writing/functors-applicatives-and-monads-in-elixir/

defmodule App.Maybe do
  @type t :: %__MODULE__{
    just: term,
    nothing: boolean
  }
  defstruct just: nil,
    nothing: false

  # h struct
  # 忽略 string key
  # defmodule User do
  #   defstruct name: ""
  # end
  # struct(User, [name: "Bill"])
  # struct(User, name: "Bill")
  # struct(User, %{name: "Bill"})

  def just(v), do: __MODULE__ |> struct(just: v)
  def nothing, do: __MODULE__ |> struct(nothing: true)
end

defprotocol Functor do
  @spec fmap(t, (term -> term)) :: t
  def fmap(functor, fun)
end
defimpl Functor, for: App.Maybe do

end
# App.Maybe.just(3)
# App.Maybe.nothing()
