-module(irc_mod).

-export([get/0, get/1, get/2, get/3]).

-import(lists, [reverse/1]).
-compile({no_auto_import, [get/0, get/1]}).

-define(TCP_OPTIONS, [binary, {packet, 0}]).

get() ->
  get("erlang.org").

get(Host) ->
  get(Host, 80).

get(Host, Port) ->
  Req = "GET /doc/index.html HTTP/1.1\r\nHost: erlang.org\r\n\r\n",
  get(Host, Port, Req).

get(Host, Port, Req) ->
  {ok, Sock} = gen_tcp:connect(Host, Port, ?TCP_OPTIONS),
  % GET /doc/index.html HTTP/1.1
  % Host: erlang.org
  % Req = "GET /doc/index.html HTTP/1.1\r\nHost: erlang.org\r\n\r\n",
  % Req = "GET /doc/index.html HTTP/1.1\r\n\r\n",
  ok = gen_tcp:send(Sock, Req),
  info(recv_data(Sock, [])).

recv_data(Sock, SoFar) ->
  receive
    {tcp, Sock, Bin} ->
      recv_data(Sock, [Bin|SoFar]);
    {tcp_closed, Sock} ->
      list_to_binary(reverse(SoFar))
  end.

info(Res) ->
  io:format("~s~n", [Res]),
  io:format("~p~n", [Res]),
  Res_List = string:tokens(binary_to_list(Res), "\r\n"),
  io:format("~p~n", [Res_List]).
