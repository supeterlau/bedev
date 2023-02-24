-module(b).
-export([x/0]).

% x() -> 1.

% erl10:start(_) 运行中修改 b 代码
% 需要 c(b). 重新编译

x() -> 2.
