defmodule Server do
  Module.register_attribute __MODULE__, :param, accumulate: true

  @vsn 2
  @api "example.com/v1"

  @moduledoc """
  Provides server functions

  ## Example

      iex> Server.start(9000)
      Running at localhost:9000

  """

  @doc """
  Start server
  """
  def start(port), do: "Running at localhost:#{port}"

  @param :filter1
  def first_request_api, do: "request #{@api} #{inspect @param}"

  @api "example.com/v2"

  @param :filter2
  def second_request_api, do: "request #{@api} #{inspect @param}"
end

Server.first_request_api |> IO.puts

Server.second_request_api |> IO.puts

