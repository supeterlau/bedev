#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname factorial -mnesia debug verbose

main([String]) ->
  try
    N = list_to_integer(String),
    F = fact(N),
    io:format("factorial ~w = ~w \n", [N, F])
  catch
    _:_ -> 
      usage()
  end;

main(_) ->
  usage().

usage() ->
  io:format("usage: factorial of integer \n"),
  halt(1).

fact(0) -> 1;
fact(N) -> N * fact(N-1).

