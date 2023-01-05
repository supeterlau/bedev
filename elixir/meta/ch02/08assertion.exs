defmodule Ch02.Assertion do

  defmacro __using__(_options) do
    quote do
      import unquote(__MODULE__) 

      Module.register_attribute __MODULE__, :tests, accumulate: true

      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_) do
    quote do
      # caller's module
      def run(), do: Ch02.Assertion.Test.run(@tests, __MODULE__)
    end
  end

  defmacro test(description, do: tests_block) do
    test_func = String.to_atom(description)
    quote do
      # 在 tests 中注册元组
      @tests {unquote(test_func), unquote(description)}
      # 定义函数 test_func
      # 运行 tests_block
      def unquote(test_func)(), do: unquote(tests_block)
    end
  end

  defmacro assert({operator, _, [lhs, rhs]}) do
    quote bind_quoted: [operator: operator, lhs: lhs, rhs: rhs] do
      Ch02.Assertion.Test.assert(operator, lhs, rhs)
    end
  end
end

defmodule Ch02.Assertion.Test do

  def run(tests, module) do
    Enum.each tests, fn {test_func, description} ->
      case apply(module, test_func, []) do
        :ok -> IO.write "."
        {:fail, reason} -> IO.puts """
          FAILURE: #{description}
          ===
          #{reason}
          """
      end
    end
  end

  def assert(:==, lhs, rhs) when lhs == rhs, do: :ok

  def assert(:==, lhs, rhs) do 
    {:fail, """
      Expected:       #{lhs}
      to be equal to: #{rhs}
    """}
  end

  def assert(:>, lhs, rhs) when lhs > rhs, do: :ok

  def assert(:>, lhs, rhs) do
    {:fail, """
      Expected:           #{lhs}
      to be greater than: #{rhs}
    """}
  end
end

