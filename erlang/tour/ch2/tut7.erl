-module(tut7).
-export([format_temps/1]).

format_temps(List_of_cities) ->
  Converted_List = convert_list_to_c(List_of_cities),
  print_temp(Converted_List),
  {Max_city, Min_city} = find_max_and_min(Converted_List),
  print_max_and_min(Max_city, Min_city).

% 需要转换的 City

convert_list_to_c([{Name, {f, F}} | Rest]) ->
  Converted_City = { Name, {c, (F - 32) * 5 / 9} },
  [Converted_City | convert_list_to_c(Rest)];

% 不需要转换的 City

convert_list_to_c([City | Rest]) ->
  [City | convert_list_to_c(Rest)];

convert_list_to_c([]) ->
  [].

%% print city list

print_temp([{Name, {c, Temp}} | Rest]) ->
  io:format("~-15w ~w c~n", [Name, Temp]),
  print_temp(Rest);

print_temp([]) ->
  ok.

%% find maximum minimum temperatures

find_max_and_min([City | Rest]) ->
  find_max_and_min(Rest, City, City).

find_max_and_min([{Name, {c, Temp}} | Rest],
                 {Max_Name, {c, Max_Temp}},
                 {Min_Name, {c, Min_Temp}}) ->
  if
    Temp > Max_Temp ->
      Max_City = {Name, {c, Temp}};
    true ->
      Max_City = {Max_Name, {c, Max_Temp}}
  end,
  if
    Temp < Min_Temp ->
      Min_City = {Name, {c, Temp}};
    true ->
      Min_City = {Min_Name, {c, Min_Temp}}
  end,
  find_max_and_min(Rest, Max_City, Min_City);

find_max_and_min([], Max_City, Min_City) ->
  {Max_City, Min_City}.

print_max_and_min({Max_name, {c, Max_temp}}, {Min_name, {c, Min_temp}}) ->
  io:format("Max temperature was ~w c in ~w~n", [Max_temp, Max_name]),
  io:format("Min temperature was ~w c in ~w~n", [Min_temp, Min_name]).


%% Test
%% tut7:format_temps([{moscow, {c, -10}}, {cape_town, {f, 70}}, {stockholm, {c, -4}}, {paris, {f, 28}}, {london, {f, 36}}]).f
