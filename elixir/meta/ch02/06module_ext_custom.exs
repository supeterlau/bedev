defmodule Ch02.ModuleCustom do

  defmacro fake_use(module, options \\ []) do
    quote do
      IO.puts "Using fake use..."
      import unquote(module)
      unquote(module).__using__(options)
    end
  end

  defmacro extend(options \\ []) do
    quote do
      import unquote(__MODULE__)
      def fake_run do
        IO.puts "Running all tests ..."
      end
    end
  end
end
