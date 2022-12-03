# defmodule ListNode do
#   @type t :: %__MODULE__{
#           val: integer,
#           next: ListNode.t() | nil
#         }
#   defstruct val: 0, next: nil
# end

# ListNode.t | nil 对应 list 类型

# defmodule Solution do
#   @spec add_two_numbers(l1 :: ListNode.t | nil, l2 :: ListNode.t | nil) :: ListNode.t | nil
#   def add_two_numbers(l1, l2) do
#     l1.next
#   end
# end

defmodule ListNode do
  @type t :: %__MODULE__{
          val: integer,
          next: ListNode.t() | nil
        }
  defstruct val: 0, next: nil
end

defmodule Code.Solution do
  def get_v(tuple, idx) do
    if idx < tuple_size(tuple) do
      elem(tuple, idx)
    else
      0
    end
  end

  def p1(t1,t2) do
    range = Enum.max([tuple_size(t1), tuple_size(t2)])
    {result, acc} = 0..range-1
    |> Enum.reduce({[], 0}, fn idx, {result, acc}-> 
      v1 = get_v(t1, idx)
      v2 = get_v(t2, idx)
      v3 = v1 + v2 + acc
      {v3, acc} = if v3 >= 10 do
        {v3 - 10, 1}
      else
        {v3, 0}
      end
      {[v3|result], acc}
    end)
    if acc == 0 do
      result
    else
      [acc|result]
    end
  end

  def start() do
    t1 = {1,2,3}
    t2 = {7,8,9}
    p1(t1, t2)

    t1 = {1,2,3,3,4,5}
    t2 = {7,8,9}
    p1(t1, t2)

    t1 = {9,9,9,9,9}
    t2 = {1,1,1,1,1,1}
    p1(t1, t2)
  end
end

Code.Solution.start()
|> IO.inspect(charlists: :list)
