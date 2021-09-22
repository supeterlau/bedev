-module(code01).
-export([sum_tail/1, sum_tail/2]).

sum_tail(List) ->
  sum_tail(List, 0).

sum_tail([Head | Tail], Acc) ->
  sum_tail(Tail, Head + Acc);
sum_tail([], Acc) ->
  Acc.

% code01:sum_tail([11, 22, 33]).
