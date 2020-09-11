-module(tut19).

-export([pong/0]).

pong() ->
  receive
    {ping, Ping_PID} ->
      io:format("Pong received ping~n", []),
      Ping_PID ! pong,
      pong()
  after 5000 ->
          io:format("Pong timed out~n",[])
  end.

% start_ping(Pong_Node) ->
%   spawn(tut19, ping, [3, Pong_Node]).
%
%   Pong_Node: pong@localhost
% tut19:start_ping(pong@localhost).
