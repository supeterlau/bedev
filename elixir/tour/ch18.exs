regex = ~r/foo|bar/i

("foo" =~ regex) |> IO.puts

("FOO" =~ regex) |> IO.puts

("https://baidu.com" =~ ~r(^https?://)) |> IO.puts

~s(use "double" without escape) |> IO.puts

~c(char list with 'single quotes') |> IO.puts

~w(foo bar bat)a |> IO.inspect

~s(Do escape and interpolation \x26 #{"inter" <> "polation"}) |> IO.puts

~S(No escape and interpolation \x26 #{"inter" <> "polation"}) |> IO.puts

~s"""
use as
heredoc
string
""" |> IO.puts

~s"""
Converts double-quotes to single-quotes.

## Examples

    iex> convert("\\\"foo\\\"")
    "'foo'"

""" |> IO.puts

~S"""
Converts double-quotes to single-quotes.

## Examples

    iex> convert("\"foo\"")
    "'foo'"

""" |> IO.puts

d = ~D[2020-08-24]
d.day |> IO.puts

t = ~T[20:01:02.0]
t.second |> IO.puts

ndt = ~N[2020-08-24 21:34:35]
ndt.calendar |> IO.puts

dt = ~U[2020-08-24 21:34:35Z]
# dt = ~U[2020-08-24 21:34:35+0008Z]
dt.time_zone |> IO.puts

defmodule Tour do
  defmodule IntegerSigils do
    def sigil_i(string, []), do: String.to_integer(string)
    def sigil_i(string, [?n]), do: -sigil_i(string, [])
  end

  def run do
    import IntegerSigils 
    ~i(42)n |> IO.puts
  end
end

Tour.run
