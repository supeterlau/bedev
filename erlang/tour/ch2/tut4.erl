-module('tut4').
-export([list_length/1]).

list_length([]) ->
  0;
list_length([First | Rest]) ->
  1 + list_length(Rest).

%% tut4:list_length([1,2,3,4,5,6,7]).
