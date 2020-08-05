-module(tut16).
-export([start/0, ping/1, pong/0]).

ping(0) ->
  pong ! finished,
  io:format("Ping finished~n", []);

ping(N) ->
  pong ! {ping, self()},
  receive
    pong ->
      io:format("Ping received pong~n", [])
  end,
  ping(N - 1).

pong() ->
  receive
    finished ->
      io:format("Pong finished~n", []);
    {ping, Pong_PID} ->
      io:format("Pong received ping~n", []),
      Pong_PID ! pong,
      pong()
  end.

start() ->
  register(pong, spawn(tut16, pong, [])),
  spawn(tut16, ping, [3]).
