-module(tut6).
-export([list_max/1]).

list_max([Head | Rest]) ->
  list_max(Rest, Head).

%% 函数重载 参数数量不同 (类型不同 无法重载)
%% Res Result
list_max([], Res) -> 
  Res;
list_max([Head|Rest], Result_so_far) when Head > Result_so_far ->
  list_max(Rest, Head);
list_max([Head|Rest], Result_so_far) ->
  list_max(Rest, Result_so_far).
