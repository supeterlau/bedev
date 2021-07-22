-module(dist_demo).

-export([rpc/4, start/1, info/0]).

start(Node) ->
  % spawn(Node, fun() -> loop() end).
  spawn(Node, fun () -> 
                  Loop = fun(Fun) ->
                             receive
                               {_, Pid, M, F, A} -> 
                                 Pid ! {self(), (catch apply(M, F, A))}, 
                                 Fun(Fun) 
                             end
                         end,
                  Loop(Loop)
              end).

rpc(Pid, M, F, A) ->
  Pid ! {rpc, self(), M, F, A},
  receive 
    {Pid, Resp} ->
      Resp
  end.

loop() ->
  receive 
    {_, Pid, M, F, A} ->
      Pid ! {self(), (catch apply(M, F, A))},
      loop()
  end.

info() -> node().
