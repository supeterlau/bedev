# https://github.com/elixir-lang/elixir/blob/master/lib/elixir/src/elixir_tokenizer.erl

defmodule Parser do
  def parse(input) do
    # input |> Code.string_to_quoted() |> IO.inspect()
    input
    |> String.replace("\n", " _RETURN_ ")
    |> String.to_charlist()
    |> :elixir_tokenizer.tokenize([],[])
  end

  def parse() do
    input = ~S(
        type Character {
      name: String!
      appearsIn: [Episode!]!
    }
    )
    parse(input)
  end
end

# input = ~S/country in ["US", "CA"] and platform not in ["web", "appletv"]/
input = ~S(
    type Character {
  name: String!
  appearsIn: [Episode!]!
}
)
Parser.parse(input)
