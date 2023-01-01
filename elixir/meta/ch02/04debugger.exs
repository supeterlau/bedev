defmodule Ch02.Debugger do
  # only call IO.inspect in development environment
  defmacro log(expression) do
    IO.puts "In macro log"

    # if Application.get_env(:debugger, :log_level) |> IO.inspect(label: "log level") == :debug do
    if Application.get_env(:debugger, :log_level) == :debug do
      quote do
        IO.puts "=========="
        IO.inspect unquote(expression)
        IO.puts "=========="
        unquote(expression)
      end
    else
      expression
    end
  end
end
