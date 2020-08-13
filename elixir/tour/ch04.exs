x = 1
1 = x

IO.inspect x

# 2 = x

{a, b, c} = {:hello, "world", 42}

IO.inspect a
IO.inspect b
IO.inspect c

[o,p,q] = [120,130,150]
IO.inspect {o,p,q}

IO.inspect [:ok | [o,p,q]]

{m, ^o} = {110, 120}
IO.inspect m
