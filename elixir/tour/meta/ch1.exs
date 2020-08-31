defmodule Tour do

  # 获取内部形式
  def show_inner() do
    quote do: sum(1,2,3)
    quote do: 1+2
    quote do: %{1 => 2}
    # quote do: [1,2,3]
    # quote do: [sum(1,2,3),2,3]
    # quote do: {1,2,3}
    quote do: x

    quote do: (if true do :this else :that end)
    quote do: if(true, do: :this, else: :that)
    # (quote do: sum(99, 100, 101)) |> Macro.to_string

    number = 12
    Macro.to_string(quote do: 11 + number)
    Macro.to_string(quote do: 11 + unquote(number))

    func_name = :do_things
    Macro.to_string(quote do: unquote(func_name)(:things))

    # inner = [1]
    # inner = [{1}]
    inner = [1,2,3]
    # Macro.to_string(quote do: [31,32,unquote(inner),100])
    Macro.to_string(quote do: [31,32,unquote_splicing(inner),100])

    inner = %{"three" => 3}
    Macro.to_string(quote do: [31,32,unquote(inner |> Macro.escape),100])

    # inner = fn -> 100 end
    # Macro.to_string(quote do: [31,32,unquote(&inner/0 |> Macro.escape),100])
  end

  def run() do
    show_inner() |> IO.inspect
  end
end

Tour.run
