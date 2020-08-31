table = :ets.new(:buckets_registry, [:set, :protected])
# :ets.new(:buckets_registry, [:named_table])
# :ets.insert(:buckets_registry, {"Erlang", self()})

:ets.insert(table, {"Erlang", self()})

:ets.lookup(table, "Erlang") |> IO.inspect
