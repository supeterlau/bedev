%%%----FILE user_interface.erl----

%%% User interface
%%% login(Name)
%%% logoff()
%%% message(ToName, Message)

-module(user_interface).
-export([logon/1, logoff/0, message/2]).
-include("mess_interface.hrl").
-include("mess_config.hrl").

logon(Name) ->
  case whereis(mess_client) of
    undefined ->
      register(mess_client,
               spawn(mess_client, client,[?server_node, Name]));
    _ -> already_logged_on
  end.

logoff() ->
  mess_client ! logoff.

message(ToName, Message) ->
  case whereis(mess_client) of
    undefined ->
      not_logged_on;
    _ -> mess_client ! #message_to{to_name=ToName, message=Message},
         ok
  end.

%%%----END FILE----
