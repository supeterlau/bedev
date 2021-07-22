RN_IP = 'xubuntu01@192.168.101.9'.
Pid = spawn(RN_IP, RemoteFun).
Pid ! {rpc, self(), erlang, node, []}.
flush().
Rpc = fun (Pid, M, F, A) -> 
  Pid ! {rpc, self(), M, F, A},
  receive
    {Pid, Resp} -> Resp
  end
end.

RemoteFun = fun () -> 
  Loop = fun(Fun) ->
    receive
      {_, Pid, M, F, A} ->
        Pid ! {self(), (catch apply(M, F, A))},
        Fun(Fun)
    end
  end,
  Loop(Loop)
end.

Rpc(Pid, file, get_cwd, []).
Rpc(Pid, file, read_file, [".gitignore"]).
