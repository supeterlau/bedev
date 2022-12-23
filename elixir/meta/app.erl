-module(app).

-export([loop/1]).

loop(Nodes) ->
  Nodes_List = maps:to_list(Nodes),
  {N1s, _} = lists:foldl(
    fun({Roles, Count}, {NodesIn, Number}) -> 
        {[{Roles, lists:seq(Number+1, Number+Count)}]++NodesIn, Number+Count}
    end,
    {[], 100},
    Nodes_List
   ),
  lists:map(fun ({Key, Node_Codes}) -> lists:zip(lists:duplicate(length(Node_Codes), Key), Node_Codes) end, N1s).
