-module(man09).

-export([start/0]).

-define(ADD(X, Y), X + Y).
-define(message, "Yeah").
-define(CALL(Func), io:format("Call ~s: ~w~n", [??Func, Func])).

fakeFunction(M, N) ->
  M + N.

start() ->
  info().

info() ->
  io:format("machine name: ~w~n", [?MACHINE]),
  io:format("otp: ~w~n", [?OTP_RELEASE]),
  io:format("Say: ~s~n", [?message]),
  ?CALL(fakeFunction(100, 200)),
  io:format("ADD(10, 100): ~B~n", [?ADD(10, 100)]).
