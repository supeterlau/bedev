-module(tour1).
-export([sum_tail/1]).

sum_tail(List) ->
  sum_tail(List, 0).


sum_tail([Head | Tail], Acc) ->
  Head + sum_tail(Tail, Acc);

sum_tail([], Acc) ->
  Acc.
