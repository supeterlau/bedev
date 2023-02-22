%% erlang.org/doc/tutorial/nif.html
%%
%% using_c.erl
%% using_c_nif.c
%% impl.c 方法实现

%% gcc -o using_c_nif.so -fpic -shared impl.c using_c_nif.c

-module(using_c).
-export([fibonacci/1, foo/1, bar/1, factorial/1]).
%% auto call init/0
-on_load(init/0).

init() ->
	%% unix: using_c_nif.so
	%% win : using_c_nif.dll
	ok = erlang:load_nif("./using_c_nif", 0).

%% placeholder

fibonacci(_X) ->
	exit(nif_library_not_loaded).

factorial(_X) ->
	exit(nif_library_not_loaded).

foo(_X) ->
	exit(nif_library_not_loaded).

bar(_X) ->
	exit(nif_library_not_loaded).
