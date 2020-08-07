-module(tut18).
-export([start/1, ping/2, pong/0]).

ping(0, Pong_Node) ->
  {pong, Pong_Node} ! finished,
  io:format("Ping finished~n", []);

ping(N, Pong_Node) ->
  {pong, Pong_Node} ! {ping, self()},
  receive
    pong ->
      io:format("Ping received pong~n", [])
  end,
  ping(N - 1, Pong_Node).

pong() ->
  receive
    finished ->
      io:format("Pong finished~n", []);
    {ping, Pong_PID} ->
      io:format("Pong received ping~n", []),
      Pong_PID ! pong,
      pong()
  end.

start(Ping_Node) ->
  register(pong, spawn(tut18, pong, [])),
  spawn(Ping_Node, tut18, ping, [3, node()]).
