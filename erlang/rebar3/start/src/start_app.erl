%%%-------------------------------------------------------------------
%% @doc start public API
%% @end
%%%-------------------------------------------------------------------

-module(start_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    start_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
