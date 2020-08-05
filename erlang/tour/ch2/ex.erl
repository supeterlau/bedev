-module(ex).

-record(rec, {a, b = val()}).

val() ->
    3.

%% c(ex).
%% rr(ex). 载入 record
%% #rec{}.
%% #rec{b=3}.
