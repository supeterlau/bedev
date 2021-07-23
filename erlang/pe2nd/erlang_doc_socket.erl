-module(irc_mod).
-export([client/3, get/0]).

client(Host, Port, Message) ->
  {ok, Sock} = gen_tcp:connect(Host, Port, [
                                            {active, false},
                                            {send_timeout, 5000},
                                            {packet, 2}
                                           ]),
  loop(Sock),
  % gen_tcp:send(Sock, Message),
  A = gen_tcp:recv(Sock, 0),
  gen_tcp:close(Sock),
  A.

loop(Sock) ->
  receive
    Message ->
      io:format("~p~n", [Message])
    % {Client, send_data, Binary} ->
    %   case gen_tcp:send(Sock, [Binary]) of
    %     {error, timeout} ->
    %       io:format("Send timeout, closing!~n", []),
    %       % handle_send_timeout(),
    %       Client ! {self(), {error_sending, timeout}},
    %       gen_tcp:close(Sock);
    %     {error, OtherSendError} ->
    %       io:format("Some other error on socket (~p), closing~n", [OtherSendError]),
    %       Client !{self(), {error_sending, OtherSendError}},
    %       gen_tcp:close(Sock);
    %     ok ->
    %       Client !{self(), data_sent},
    %       loop(Sock)
    %   end
  end.


get() ->
  Host = "www.baidu.com",
  Message = "GET /index.html HTTP/1.1\nHost: "++ Host ++"\n",
  client(Host, 80, Message).
