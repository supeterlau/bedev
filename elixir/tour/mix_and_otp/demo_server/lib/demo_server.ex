defmodule DemoServer do
  @compile :nowarn_unused_function

  @moduledoc """
  Documentation for `DemoServer`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> DemoServer.hello()
      :world

  """
  def hello do
    :world
  end

  defp hello do
    :world
  end

  defp unused_hello do
    :world
  end
end
