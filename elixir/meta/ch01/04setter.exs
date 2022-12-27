defmodule Setter do
  defmacro bind_name(string) do
    quote do
      name = unquote(string)
    end
  end

  defmacro bind_name!(string) do
    quote do
      var!(name) = unquote(string)
    end
  end
end
