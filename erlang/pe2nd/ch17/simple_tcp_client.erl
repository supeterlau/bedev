-module(simple_tcp_client).
-export([nano_tcp_request/1]).

nano_tcp_request(Str) ->
  {ok, Socket} = gen_tcp:connect("localhost", 2345, [binary, {packet, 4}]),
  ok = gen_tcp:send(Socket, term_to_binary(Str)),
  receive
    {tcp, Socket, Bin} ->
      io:format("Client received binary = ~p~n", [Bin]),
      Val = binary_to_term(Bin),
      io:format("Client result = ~p~n", [Val]),
      gen_tcp:close(Socket)
  end.

% 执行字符串代码
% simple_tcp_client:nano_tcp_request("list_to_tuple([2+3*4, 10+20])").
