-module(socket_example).
-export([nano_get_url/0, nano_get_url/1]).
-import(lists, [reverse/1]).

% https://cn.bing.com/

nano_get_url() ->
  nano_get_url("httpbin.org").

nano_get_url(Host) ->
  {ok, Socket} = gen_tcp:connect(Host, 80, [binary, {packet, 0}]),
  ok = gen_tcp:send(Socket, "GET / HTTP/1.0\r\n\r\n"),
  receive_data(Socket, []).

receive_data(Socket, SoFar) ->
  _ = receive
    {tcp, Socket, Bin} ->
      receive_data(Socket, [Bin | SoFar]);
    {tcp_closed, Socket} ->
      list_to_binary(reverse(SoFar))
  end,
  io:format("~s~n", [SoFar]).

% display content
% io:format("~p~n", [B]).
% string:tokens(binary_to_list(B), "\r\n").


