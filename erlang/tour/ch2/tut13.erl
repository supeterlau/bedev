-module(tut13).
-export([foreach/2, 
         map/2, 
         run/0,
         convert_list_to_c/1]).

foreach(Fun, [First|Rest]) ->
  Fun(First),
  foreach(Fun, Rest);
foreach(Fun, []) ->
  ok.

map(Fun, [First|Rest]) ->
  [Fun(First) | map(Fun, Rest)];
map(Fun, []) ->
  [].

run() ->
  Print_City = fun({City, {X, Temp}}) -> io:format("~15w ~w ~w~n", [City, X, Temp]) end,
  lists:foreach(Print_City, [ {moscow, {c, -10}},
                             {cape_town, {f, 70}},
                             {stockholm, {c, -4}}
                            ]),
  convert_list_to_c([{moscow, {c, -10}}, {cape_town, {f, 70}}, {stockholm, {c, -4}}, {paris, {f, 28}}, {london, {f, 36}}]).

convert_to_c({Name, {f, Temp}}) ->
  {Name, {c, trunc((Temp - 32) * 5 / 9)}};
convert_to_c({Name, {c, Temp}}) ->
  {Name, {c, Temp}}.

convert_list_to_c(List) ->
  New_list = lists:map(fun convert_to_c/1, List),
  lists:sort(fun({_, {c, Temp1}}, {_, {c, Temp2}}) -> Temp1 < Temp2 end, New_list).
