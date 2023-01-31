defmodule Tour do
  defmodule LousyCalculatorNoType do
    @spec add(number, number) :: {number, String.t}
    def add(x, y), do: {x + y, "You need a calculator to do that?!"}

    @spec multiply(number, number) :: {number, String.t}
    def multiply(x, y), do: { x * y , "Jeez, come on!"}
  end

  defmodule LousyCalculator do
    @typedoc """
    Just a number followed by a string.
    """
    @type number_with_remark :: {number, String.t}

    @spec add(number, number) :: number_with_remark
    def add(x, y) do
      IO.puts('run add')
      {x + y, "You need a calculator to do that?!"}
    end

    @spec multiply(number, number) :: number_with_remark
    def multiply(x, y), do: { x * y , "Jeez, come on!"}
  end

  defmodule Parser do
    @callback parse(String.t) :: {:ok, term} | {:error, String.t}
    @callback extensions() :: {String.t}

    def parse!(impl, contents) do
      case impl.parse(contents) do
        {:ok, data} -> data
        {:error, error} -> raise ArgumentError, "parsing error: #{error}"
      end
    end
  end

  defmodule JSONParser do
    @behaviour Parser

    @impl Parser
    def parse(str), do: {:ok, "Json Parser " <> str}

    @impl Parser
    # def extensions, do: ["json"]
    def extensions, do: "json"
  end

  defmodule YAMLParser do
    @behaviour Parser

    @impl Parser
    def parse(str), do: {:ok, "Yaml Parser " <> str}

    @impl Parser
    # def extensions, do: ["json"]
    def extensions, do: "yaml"
  end

  def run do
    # LousyCalculator.add("aaa", "bbb") |> IO.puts

    JSONParser.extensions |> IO.inspect

    Parser.parse!(YAMLParser, "just some yaml") |> IO.puts
  end
end

IO.puts("Hello");Tour.run
