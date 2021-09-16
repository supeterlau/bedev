#!/usr/bin/env escript
%% -*- erlang -*-
%%! -smp enable -sname factorial -mnesia debug verbose

main(_) ->
  io:format("2 + 15 = ~w~n", [2 + 15]),
  io:format("49 * 100 = ~w~n", [49 * 100]),
  io:format("1892 - 1472 = ~w~n", [1892 - 1472]),
  io:format("5 / 2 = ~w~n", [5 / 2]),
  io:format("5 div 2 = ~w~n", [5 div 2]),
  io:format("5 rem 2 = ~w~n", [5 rem 2]),

  io:format("(50 * 100) - 4999 = ~w~n", [(50 * 100) - 4999]),
  io:format("2#101010, 8#0677, 16#AE ~w ~w ~w \n", [2#101010, 8#0677, 16#AE]),

  io:format("true and false = ~w~n", [true and false]),
  io:format("0 == false = ~w~n", [0 == false]),
  io:format("1 < false = ~w~n", [1 < false]),

  X = 11, Y = 12,
  io:format("tuple Point = ~w~n", [{X, Y}]),
  io:format("tagged tuple: ~w~n", [{point, {X, Y}}]),

  io:format("List = ~w~n", [[1,2,3,{numbers, [4,5,6]}, 3.14, atom]]),
  io:format("List = ~w~n", [[97,98,99]]),
  io:format("[1,2,3] -- [1,2] -- [2] = ~w~n", [[1,2,3] -- [1,2] -- [2]]),

  List = [1,2,3,4,5],
  Double = [2 * N || N <- List],
  io:format("double of ~w : ~w~n", [List, Double]),

  Even = [N || N <- List, N rem 2 =:= 0],
  io:format("even of ~w : ~w~n", [List, Even]),

  RestaurantMenu = [
                    {steak, 5.99},
                    {beer, 3.99},
                    {poutine, 3.50},
                    {kitten, 20.99},
                    {water, 0.00}
                   ],
  % taxes (7%)
  Prices = [{Item, Price * 1.07} || {Item, Price} <- RestaurantMenu, Price >= 3, Price =< 10],
  io:format("Prices: ~w~n", [Prices]),

  Products = [{X, Y} || X <- [1,2,3], Y <- [4,5,6]],
  io:format("[1,2,3] x [4,5,6] : ~w~n", [Products]),

  Color = 16#F09A29,
  Pixel = <<Color:24>>,
  io:format("Pixel : ~w~n", [Pixel]),

  Pixels = <<213,45,132,64,76,32,76,0,0,234,32,15>>,
  <<Pix1:24, Pix2:24, Pix3:24, Pix4:24>> = Pixels,
  io:format("Pix1 : ~w~n", [Pix1]),

  <<R:8, G:8, B:8>> = <<Pix1:24>>,
  io:format("R : ~w~n", [R]),

  % <<Y:4/little-unit:8>> = <<72,0,0,0>>,
  % io:format("Y : ~w~n", [Y]),

  io:format("2#00010 bsl 1 : ~w~n", [2#00010 bsl 1]),

  % <<SourcePort:16, DestinationPort:16, AckNumber:32, DataOffset:4, _Reserved:4, Flags:8, WindowSize:16, CheckSum: 16, UrgentPointer:16, Payload/binary>> = TCPBinary,

  io:format("bit string ~w~n", [<<"Hello Bitstring">>]),

  BC1 = [X || <<X>> <= <<1,2,3,4,5>>, X rem 2 == 0],
  io:format("BC1 : ~w~n", [BC1]),

  BC_RGB = [{R,G,B} || <<R:8,G:8,B:8>> <= Pixels],
  io:format("BC_RGB : ~w~n", [BC_RGB]),

  BC_Pixels = << <<R:8,G:8,B:8>> || {R,G,B} <- BC_RGB >>,
  io:format("To Pixels : ~w~n", [BC_Pixels]),
  halt(0).
