-module(person).
-export([init/1, say/3]).

init(Name) ->
  receive
    {From, Message} ->
      io:format("~p say: ~s (~s)~n", [From, Message, Name]),
      init(Name)
  end.
  % after 5000 ->
  %         io:format("Timeout")

say(From, To, Message) ->
  To ! {From, Message}.

% person:get_name(Person)
