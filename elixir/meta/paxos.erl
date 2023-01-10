-module(paxos).

-export([start_reg/0, start_generator/0,
				generate_id/2, log/1, is_acceptors_valid/1,
        format_nodes/1, start_nodes/2]).

-define(NODE_TIMEOUT, 1500).

register(Pids) ->
  New_Pids = receive
		{list, Role, To} ->
		  To ! maps:get(Role, Pids, []);
		{all, To} ->
			To ! Pids;
    {Event, New_Pid, Roles} ->
      % broadcast_join
      case lists:member(Event, [join, leave]) and is_pid(New_Pid) of
				% true ->
          % [Pid ! {Event, New_Pid} || Pid <- Pids],
          % [New_Pid] ++ Pids;
        true ->
          if
            Event == join ->
              % Pairs = maps:from_list(lists:zip(Roles, lists:duplicate(length(Roles), New_Pid))),
              Pairs = lists:zip(Roles, lists:duplicate(length(Roles), New_Pid)),
              lists:foldl(fun({Role, Pid}, Init) -> maps:update_with(Role, fun(Old_Pids) -> [Pid | Old_Pids] end, Init) end, Pids, Pairs);
            Event == leave ->
              % Pairs = maps:from_list(lists:zip(Roles, lists:duplicate(length(Roles), New_Pid))),
              Pairs = lists:zip(Roles, lists:duplicate(length(Roles), New_Pid)),
              lists:foldl(fun({Role, Pid}, Init) -> maps:update_with(Role, fun(Old_Pids) -> [Pid | Old_Pids] end, Init) end, Pids, Pairs)
          end;
        false -> Pids
      end
  end,
  register(New_Pids).

start_reg() ->
	% spawn(fun() -> register([]) end).
  Init = maps:from_list(lists:zip([proposer, acceptor, listener], lists:duplicate(3, []))),
	spawn(fun() -> register(Init) end).

% spawn list_pids
list_pids(Register, Role) ->
	Register ! {list, Role, self()},
  receive
    Pids -> Pids
  end.

id_generator() ->
  receive
    {propose_id, Node_Code, To} ->
      To ! {generated, {os:timestamp(), Node_Code}}
  end,
  id_generator().

start_generator() ->
  spawn(fun() -> id_generator() end).

generate_id(Node_Code, ID_Generator) ->
  ID_Generator ! {propose_id, Node_Code, self()},
  receive
    {generated, ID} -> ID
  end.

wait_response({To, Leaders_Count, Leader_Info, Major_Count, Timeout, Res_Type}) ->
  Start = os:timestamp(),
  State = receive
    {Res_Type, {Leader, Propose_ID, Propose_Value}} ->
      Diff = math:ceil(timer:now_diff(os:timestamp(), Start) / 1000),
      New_Timeout = if
        Timeout > Diff -> Timeout - Diff;
        true -> 0
      end,
      Key = {Leader, Propose_ID, Propose_Value},
      LC = maps:update_with(Key, fun (C) -> C + 1 end, 0, Leaders_Count),
      Key_Count = maps:get(Key, LC),
      New_Leader_Info = if
        Key_Count > Major_Count -> Key;
        true -> Leader_Info
      end,
      {To, LC, New_Leader_Info, Major_Count, New_Timeout, Res_Type}
    after
      Timeout ->
        {To, Leaders_Count, Leader_Info, Major_Count, 0, Res_Type}
  end,
  % New_Timeout > 0 andalso ask_leader(State).
  Rest_Time = element(5, State),
  if
    Rest_Time > 0 ->
      wait_response(State);
    true ->
      To ! {Res_Type, Leader_Info}
  end.

start_wait(State) -> spawn(fun() -> wait_response(State) end).

loop({Leader_Info, Value, Req, Node_Code}=State, ID_Generator, Register) ->
  State = receive

    % proposer
    
    {request_consensus, Value, Req} ->
			Acceptors = list_pids(acceptor, Register),
      % wait prepare_response
      Acceptors_Count = length(Acceptors),
      Wait_State = {self(), {nil, nil, 0}, nil, major(Acceptors_Count), ?NODE_TIMEOUT * Acceptors_Count},
      Reporter = start_wait(Wait_State),
      [Pid ! {prepare, Leader_Info, Reporter} || Pid <- Acceptors],
      {Leader_Info, Value, Req, Node_Code};

    {prepare_result, {_New_Leader_Pid, New_Leader_ID, _New_Leader_Value}=New_Leader_Info} ->
      % wait prepare_response
      Updated_Leader_Info = if
        % ID 为 nil 发起 accept
        New_Leader_ID == nil  -> 
          Acceptors = list_pids(acceptor, Register),
          Acceptors_Count = length(Acceptors),
          Gen_Leader_ID = generate_id(Node_Code, ID_Generator),
          Gen_Leader_Info = {self(), Gen_Leader_ID, Value},
          Wait_State = {self(),  Gen_Leader_Info, nil, major(Acceptors_Count), ?NODE_TIMEOUT * Acceptors_Count},
          Reporter = start_wait(Wait_State),
          [Pid ! {accept, Leader_Info, Reporter} || Pid <- Acceptors],
          Gen_Leader_Info;
        % ID 不为 nil 返回给 Req
        true -> 
          Req ! {current_leader, New_Leader_Info},
          New_Leader_Info
      end,
      {Updated_Leader_Info, Value, Req, Node_Code};

    {accept_result, Leader_Info} ->
      Req ! {current_leader, Leader_Info},
      {Leader_Info, Value, Req, Node_Code};

    % acceptor

    {prepare, {_New_Propose_Pid, New_Propose_ID, _New_Propose_Value}=New_Propose_Info, Reporter} -> 
      {_, Propose_ID, _} = Leader_Info,
      Res_Leader_Info = if
        Propose_ID < New_Propose_ID -> New_Propose_Info;
        true -> Leader_Info
      end,
      Reporter ! {prepare_response, Res_Leader_Info},
      {Res_Leader_Info, Value, Req, Node_Code};
    
    {accept, {_New_Propose_Pid, New_Propose_ID, _New_Propose_Value}=New_Propose_Info, Reporter} ->
      {_, Propose_ID, _} = Leader_Info,
      Res_Leader_Info = if
        Propose_ID < New_Propose_ID -> New_Propose_Info;
        true -> Leader_Info
      end,
      Reporter ! {accept_response, Res_Leader_Info},
      {Res_Leader_Info, Value, Req, Node_Code}
		end,
	loop(State, ID_Generator, Register).

% Roles
% proposer acceptor
% acceptor
% listener
start_node(ID_Generator, Register, Roles, Node_Code) ->
	State = {{}, nil, nil, Node_Code},
	New_Pid = spawn(fun() -> loop(State, ID_Generator, Register) end),
  Register ! {join, New_Pid, Roles}.

start_nodes(ID_Generator, Register) ->
  Nodes=#{[proposer, acceptor] => 5, [acceptor] => 10, [listener]=>10},
  Formatted_Nodes = format_nodes(Nodes),
  [start_node(ID_Generator, Register, Roles, Node_Code) || {Roles, Node_Code} <- Formatted_Nodes].
  
format_nodes(Nodes) ->
  Nodes_List = maps:to_list(Nodes),
  {N1s, _} = lists:foldl(
    fun({Roles, Count}, {NodesIn, Number}) -> 
        {[{Roles, lists:seq(Number+1, Number+Count)}]++NodesIn, Number+Count}
    end,
    {[], 100},
    Nodes_List
   ),
  N2s = lists:map(fun ({Key, Node_Codes}) -> lists:zip(lists:duplicate(length(Node_Codes), Key), Node_Codes) end, N1s),
  lists:flatten(N2s).

is_acceptors_valid(Pids) ->
  Count = length(Pids),
  (Count >= 3) and (Count rem 2 == 1).

major(Count) ->
  if
    Count rem 2 == 0 -> (Count div 2) + 1;
    Count rem 2 == 1 -> (Count+1) div 2
  end.

% log([1,1,{a1,a2}]).
log(Msg) ->
  % io:format("~w~n", [Msg]),
  % io:format("~p~n", [Msg]).
  io:format("~s~n", [Msg]).
