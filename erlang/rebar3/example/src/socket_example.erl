-module(socket_example).

-import(lists, [reverse/1]).

-export([get_url/0, get_url/1]).

get_url() -> get_url("www.baidu.com").

get_url(Host) ->
    {ok, Socket} = gen_tcp:connect(Host,
                                   80,
                                   [binary, {packet, 0}]),
    ok = gen_tcp:send(Socket, "GET / HTTP/1.0\r\n\r\n"),
    receive_data(Socket, []).

receive_data(Socket, SoFar) ->
    receive
        {tcp, Socket, Bin} ->
            receive_data(Socket, [Bin | SoFar]);
        {tcp_closed, Socket} -> list_to_binary(reverse(SoFar))
    end.
