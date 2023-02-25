-module(erl10).
-compile(export_all).

% 同时存在两个版本 latest_old_version 和 new_version
% 其他旧版本 process 会被 kill
% 每次调用模块的 new_version 

start(Tag) ->
  spawn(fun() -> loop(Tag) end).

loop(Tag) ->
  sleep(),
  Val = b:x(),
% erl10:start(_) 运行中修改 erl10 代码
% c(erl10). 重新编译
  % io:format("Vsn1 (~p) b:x() = ~p~n", [Tag, Val]),
  % io:format("Vsn2 (~p) b:x() = ~p~n", [Tag, Val]),
  io:format("Vsn3 (~p) b:x() = ~p~n", [Tag, Val]),
  loop(Tag).

sleep() ->
  receive
    after 3000 -> true
  end.
