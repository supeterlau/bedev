-module(echo).
-author('dev').

-export([listen/1]).

-define(TCP_OPTIONS, [binary, {packet, 0}, {active, false}, {reuseaddr, true}]).

listen(Port) ->
  {ok, LSock} = gen_tcp:listen(Port, ?TCP_OPTIONS),
  accept(LSock).

accept(LSock) ->
  {ok, Sock} = gen_tcp:accept(LSock),
  spawn(fun()->loop(Sock) end),
  accept(LSock).

loop(Sock) ->
  case gen_tcp:recv(Sock, 0) of
    {ok, Data} ->
      io:format("Server Get:~n"),
      io:format("~p~n", [Data]),
      gen_tcp:send(Sock, Data),
      loop(Sock);
    {error, closed} ->
      ok
  end.
