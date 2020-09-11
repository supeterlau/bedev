%%%----FILE mess_interface.hrl----

%%% Message interface between client, server, client shell

%%% client to server
-record(logon, {client_pid, username}).
-record(message, {client_pid, to_name, message}).
%%% {'EXIT', Client_Pid, Reason}

%%% server to client, received in await_result/0

-record(abort_client, {message}).
%%% messages: user_exists_at_other_node, you_are_not_logged_on

-record(server_reply, {message}).
%%% messages: logged_on, receiver_not_found, sent

%%% server to client, received in client/1

-record(message_from, {from_name, message}).

%%% shell to client, received in client/1

-record(message_to, {to_name, message}).

%%%----END FILE----
