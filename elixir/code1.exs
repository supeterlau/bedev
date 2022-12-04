# defmodule ListNode do
#   @type t :: %__MODULE__{
#           val: integer,
#           next: ListNode.t() | nil
#         }
#   defstruct val: 0, next: nil
# end

defmodule Solution do
  @spec add_two_numbers(l1 :: ListNode.t | nil, l2 :: ListNode.t | nil, extra: integer) :: {ListNode.t | nil, integer}

  def add_two_numbers(nil, nil, 0) do
    nil
  end

  def add_two_numbers(nil, nil, extra) do
    %ListNode{val: extra, next: nil}
  end

  def add_two_numbers(nil, l2, extra) do
    add_two_numbers(%ListNode{val: 0, next: nil}, l2, extra)
  end

  def add_two_numbers(l1, nil, extra) do
    add_two_numbers(l1, %ListNode{val: 0, next: nil}, extra)
  end

  def add_two_numbers(l1, l2, extra) do
    val = l1.val + l2.val + extra
    {val, extra} = if val >= 10, do: {val-10, 1}, else: {val, 0}
    next = add_two_numbers(l1.next, l2.next, extra)
    %ListNode{val: val, next: next}
  end

  @spec add_two_numbers(l1 :: ListNode.t | nil, l2 :: ListNode.t | nil) :: ListNode.t | nil

  def add_two_numbers(l1, l2) do
    add_two_numbers(l1, l2, 0)
  end

  def make_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(nil, fn item, head-> 
      %ListNode{val: item, next: head}
    end)
  end
end

list1 = [9,8,8]
list2 = [1,1,2]
l1 = Solution.make_list(list1)
l2 = Solution.make_list(list2)
Solution.add_two_numbers(l1, l2)
|> IO.inspect(charlists: :list)
