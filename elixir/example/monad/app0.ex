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

defprotocol App.Functor do
  @spec fmap(t, (term -> term)) :: t
  def fmap(functor, fun)
end

defimpl App.Functor, for: App.Maybe do
  def fmap(%{nothing: true} = f, _), do: f
  def fmap(%{just: a}, fun) do
    case val = fun |> apply([a]) do
      %{nothing: true} -> val
      _ -> val |> App.Maybe.just()
    end
  end
end

defmodule App.Magic do
  def call(stat, val) do
    IO.inspect(stat, label: "App.Magic")
    IO.inspect(val, label: "App.Magic")
  end
end

defprotocol App.Applicative do
  @spec apply(t, App.Functor.t) :: t
  def apply(fun, f)
end

defimpl App.Applicative, for: App.Maybe do
  def apply(%{nothing: true} = f, _), do: f
  def apply(%{just: fun}, f) do
    f |> App.Functor.fmap(fun)
  end
end

defprotocol App.Monad do
  @spec bind(t, (term -> t)) :: t
  def bind(m, fun)
end

defimpl App.Monad, for: App.Maybe do
  def bind(%{nothing: true} = f, _), do: f
  def bind(%{just: v}, fun) do
    fun |> apply([v])
  end
end
# App.Maybe.just(3)
# App.Maybe.nothing()

add2 = fn x -> x + 2 end
to_nothing = fn _ -> App.Maybe.nothing() end
mul3 = fn x -> x * 3 end

App.Maybe.just(5)
|> App.Functor.fmap(add2)
|> IO.inspect()

App.Maybe.just(5)
|> App.Functor.fmap(add2)
|> App.Functor.fmap(mul3)
|> IO.inspect()

App.Maybe.just(5)
|> App.Functor.fmap(add2)
|> App.Functor.fmap(to_nothing)
|> App.Functor.fmap(mul3)
|> IO.inspect()

call_magic = fn file ->
  case File.stat(file) do
    {:ok, s} ->
      App.Maybe.just(&(&1 |> App.Magic.call(s)))
    {:error, _} ->
      App.Maybe.nothing()
  end
end

# call_magic.("not_found.txt")
call_magic.("app0.js")
|> App.Applicative.apply(App.Maybe.just(5))
|> IO.inspect()
