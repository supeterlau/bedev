defmodule Tour do

  defmodule FakeTest do

    @doc false
    defmacro __before_compile__(env) do
      quote do
        def run do
          Enum.each @tests, fn name -> 
            IO.puts "Running #{name} at #{__MODULE__} env: #{unquote(env)|>inspect}"
            apply(__MODULE__, name, [])
          end
        end
      end
    end
  end

  defmodule TestCase do
    import FakeTest
    # use TestCase 时调用的 callback
    @doc false
    defmacro __using__(_opts) do
      quote do
        import TestCase

        @tests []

        @before_compile TestCase
        # @before_compile FakeTest
      end
    end

    @doc """
    Defines a test case with given description.

    ## Examples
    
        test "arithmetic operations" do
            4 = 2 + 2
        end

    """
    defmacro test(description, do: block) do
      function_name = String.to_atom("test_" <> description)
      quote do
        # 每个 test case 对 @tests 赋值 (可以用累加方式，差不多)
        @tests [unquote(function_name) | @tests]
        def unquote(function_name)(), do: unquote(block)
      end
    end

    # target module 编译前，调用，插入 run/0 函数
    @doc false
    defmacro __before_compile__(_env) do
      quote do
        def run do
          # @tests 是属于目标模块的 可以直接访问
          @tests |> IO.inspect
          # @tests |> Enum.sort

          Enum.each @tests |> Enum.sort, fn name -> 
            IO.puts "Running #{name}" 
            # ok
            # IO.puts "#{unquote(__ENV__ |> Macro.escape) |> inspect}"
            apply(__MODULE__, name, [])
          end

          # ok
          # unquote(__ENV__ |> Macro.escape)
          # unquote(env |> Macro.escape)

          # fail
          # unquote(@tests)

        end
      end
    end
  end


  defmodule TestMacro do
    use TestCase

    test "hello" do
      # "hello" = "world"
      "hello" = "hello"
    end

    test "4 = 2 + 2" do
      4 = 2 + 2
    end

    test "9 = 6 + 3" do
      9 = 6 + 3
    end
  end

  def run do
    # TestMacro.test_hello()
    TestMacro.run
  end
end

Tour.run |> IO.inspect
