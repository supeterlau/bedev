defmodule Tour do
  def sigil_m(value) do
    quote do: value
  end
end

# ~m(aa) == %{aa: aa}
