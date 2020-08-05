-module(tut14).
-export([start/0, say_words/2]).

say_words(_, 0) ->
  done;
say_words(What, Times) -> 
  io:format("~p~n", [What]),
  say_words(What, Times - 1).

start() ->
  spawn(tut14, say_words, [hello, 3]),
  spawn(tut14, say_words, [goodbye, 3]).
