-module(world).
-export([start/0]).

start() ->
  BSD = spawn(person, init, ["BSD"]),
  Linux = spawn(person, init, ["Linux"]),
  person:say(BSD, Linux, "ugly os").

