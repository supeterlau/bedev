-module(messenger).
-export([
         start_server/0,
         server/1,
         logon/1,
         logoff/0,
         message/2,
         client/2
        ]).

server_node() ->
  messenger@localhost.
 %% messenger@super.

%%% server process of "messenger"
%%% User_List [{ClientPid, Name}, ...]

server(User_List) ->
  receive
    {From, logon, Name} ->
      New_User_List = server_logon(From, Name, User_List),
      server(New_User_List);
    {From, logoff} ->
      New_User_List = server_logoff(From, User_List),
      server(New_User_List);
    {From, message_to, To, Message} ->
      server_transfer(From, To, Message, User_List),
      io:format("current user list is: ~p~n", [User_List]),
      server(User_List)
  end.

start_server() ->
  %% 注册为 messenger 启动模块 messenger 中的 server 函数 参数为 []
  register(messenger, spawn(messenger, server, [[]])).

%%% 用户登录
server_logon(From, Name, User_List) ->
  %% 检查是否已经 logged on
  case lists:keymember(Name, 2, User_List) of
    true ->
      From ! {messenger, stop, user_exists_at_other_node},
      User_List;
    false ->
      From ! {messenger, logged_on},
      [{From, Name} | User_List]
  end.

server_logoff(From, User_List) ->
  lists:keydelete(From, 1, User_List).

%%% transfers message between users
server_transfer(From, To, Message, User_List) ->
  case lists:keysearch(From, 1, User_List) of
    false ->
      From ! {messenger, stop, you_are_not_logged_on};
    {value, {From, Name}} ->
      server_transfer(From, Name, To, Message, User_List)
  end.

server_transfer(From, Name, To, Message, User_List) ->
  case lists:keysearch(To, 2, User_List) of
    false ->
      From ! { messenger, receiver_not_found };
    {value, {ToPid, To}} ->
      ToPid ! {message_from, Name, Message},
      From ! {messenger, sent}
  end.

%%% User Commands

logon(Name) ->
  case whereis(mess_client) of
    undefined ->
      register(mess_client,
              spawn(messenger, client, [server_node(), Name]));
    _ -> already_logged_on
  end.

logoff() ->
  mess_client ! logoff.

message(ToName, Message) ->
  case whereis(mess_client) of
    undefined ->
      not_logged_on;
    _ -> mess_client ! {message_to, ToName, Message},
         ok
  end.

client(Server_Node, Name) ->
  {messenger, Server_Node} ! {self(), logon, Name},
  await_result(),
  client(Server_Node).

client(Server_Node) ->
  receive
    logoff ->
      {messenger, Server_Node} ! {self(), logoff},
      exit(normal);
    {message_to, ToName, Message} ->
      {messenger, Server_Node} ! {self(), message_to, ToName, Message},
      await_result();
    {message_from, FromName, Message} ->
      io:format("Message from ~p: ~p~n", [FromName, Message])
  end,
  client(Server_Node).


%%% 等待服务器响应
await_result() ->
  receive
    {messenger, stop, Why} ->
      io:format("~p~n", [Why]),
      exit(normal);
    {messenger, What} ->
      io:format("~p~n", [What])
  end.




%%% case value of
%%%   condition1 ->
%%%     clause,
%%%     clause;
%%%   condition2 ->
%%%     clause,
%%%     clause;
%%%   _ ->
%%% end.
%%%
%%% list:keymember
%%% list:keydelete
