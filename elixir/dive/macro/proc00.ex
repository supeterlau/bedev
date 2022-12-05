# Parse GraphQL Schema: ./schema.gql

defmodule App.Main do
  def run() do
    File.read!("./schema.gql")
    |> Code.string_to_quoted()
  end
end

App.Main.run()|>IO.inspect()
