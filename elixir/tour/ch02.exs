add = fn a, b -> a + b end

double = fn a -> 
  add.(a, a)
end

list = [1,:aaa, true, []]

[
div(10,2),
10/2,
rem(10,3),
0b1010,
is_boolean(10),
add.(1,2),
is_function(add),
double.(100),
# 3 |> &(double).(&1),
hd(list),

{:ok, "hello"},

elem({110, 120}, 0),

put_elem({110, 120}, 0, :ok),
:ok
] |> Enum.each(&IO.inspect(&1))
