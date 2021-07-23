-module(irc_mod).

-export([client/3, get/0]).

client(Host, Port, Message) ->
  {ok, Sock} = gen_tcp:connect(Host, Port, [
                                            binary,
                                            {active, false},
                                            {send_timeout, 5000},
                                            {packet, 2}
                                           ]),
  % ok = gen_tcp:send(Sock, Message),
  ok = gen_tcp:send(Sock, term_to_binary(Message)),
  receive
    {tcp, Sock, Bin} ->
      io:format("Get ~p~n", [Bin]),
      Val = binary_to_term(Bin),
      io:format("Content ~p~n", [Val]),
      gen_tcp:close(Sock);
    Term ->
      io:format("~p~n", [Term])
  end.

get() ->
  Host = "erlang.org",
  % IP = "192.121.151.106",
  IP = "127.0.0.1",
  Port = 9000,
  Message = "GET / HTTP/1.1\r\nHost: " ++ Host ++ "\r\n\r\n",
  client(IP, Port, Message).
