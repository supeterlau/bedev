total_price = fn price, fee -> price + fee.(price) end

flat_fee = fn _price -> 5 end 

proportional_fee = fn price -> price * 0.12 end

upcase = fn string -> String.upcase(string) end
upcase = &String.upcase/1
mult_two = & &1 * &2
[
  total_price.(1000, flat_fee),
  total_price.(1000, proportional_fee),
  upcase.("content"),
  mult_two.(9, 7)
]
|> IO.inspect()

defmodule Main do
  defmodule Checkout do
    def total_cost(price, tax_rate) do
      price * (tax_rate + 1)
    end
  end

  defmodule TaskList do
    import File, only: [write: 3, read: 1]

    @file_name "task_list.md"

    def add(task_name) do
      task = "[ ] " <> task_name <> "\n"
      # Fiile.write(@file_name, task, [:append])
      write(@file_name, task, [:append])
    end
    
    def show_list do
      # File.read(@file_name)
      read(@file_name)
    end
  end

  def exec() do
    Checkout.total_cost(100, 0.2)
    TaskList.add("Erlang")
    TaskList.add("Haskell")
    TaskList.show_list()
    |> IO.inspect()
  end
end

Main.exec()
