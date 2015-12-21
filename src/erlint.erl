-module(erlint).
-export([main/1]).

main(["--version"]) ->
    io:fwrite("erlint version 0.1.0~n");
main([File]) -> % escript passes in args in an array
    Compare = 
        fun({_,File1,{Line1,_,Err1}},{_,File2,{Line2,_,Err2}}) ->
            {File1,Line1,Err1} =< {File2,Line2,Err2};
        (X,Y) ->
            X =< Y end,
    Res = lint(File),
    case io_lib:printable_list(Res) of
        true ->
            print(Res);
        false ->
            print(lists:sort(Compare,Res))
    end;
main([]) -> % no args from escript
    io:fwrite("Usage: erlint filename.erl~n");
main(File) -> % allow callers to pass filename in a bare string
    main([File]).

lint(File) ->
    case epp:parse_file(File,[]) of
        {ok, Forms} ->
            case erl_lint:module(Forms, File) of
                % nothing wrong
                {ok, []} ->
                    [];
                % just warnings
                {ok, Warnings} ->
                    [ {warning,WFile,Warning} || {WFile,WList} <- Warnings, Warning <- WList ];
                % errors, no warnings
                {error, Errors, []} ->
                    [ {error,EFile,Error} || {EFile,EList} <- Errors , Error <- EList ];
                % errors and warnings
                {error, Errors, Warnings} ->
                    [ {error,EFile,Error} || {EFile,EList} <- Errors , Error <- EList ] ++
                    [ {warning,WFile,Warning} || {WFile,WList} <- Warnings, Warning <- WList ]
            end;
        {error, _} ->
            "Cannot open file"
    end.

% degenerate case
print([]) ->
    0;
print([{Type,File,{Line,_Module,{ErrT,{Function,Arity}}}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w ~w/~w~n",[File,Line,Type,ErrT,Function,Arity]),
    print(More);
print([{Type,File,{Line,_Module,{ErrT,{Module,Function,Arity},ErrS}}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w ~w:~w/~w (~s)~n",[File,Line,Type,ErrT,Module,Function,Arity,ErrS]),
    print(More);
print([{Type,File,{Line,_Module,{ErrT,ErrX}}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w ~w~n",[File,Line,Type,ErrT,ErrX]),
    print(More);
print([{Type,File,{Line,_Module,{ErrT,ErrX,{Block,BlockLine}}}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w ~w ~w@~w~n",[File,Line,Type,ErrT,ErrX,Block,BlockLine]),
    print(More);
print([{Type,File,{Line,_Module,{ErrT,ErrX,ErrY}}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w ~w.~w~n",[File,Line,Type,ErrT,ErrX,ErrY]),
    print(More);
print([{Type,File,{Line,_Module,[ErrT,ErrX]}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w ~w~n",[File,Line,Type,ErrT,ErrX]),
    print(More);
print([{Type,File,{Line,_Module,Err}}|More]) ->
    case io_lib:printable_list(Err) of
        true ->
            io:fwrite("~s:~w: ~w: ~s~n",[File,Line,Type,Err]);
        false ->
            io:fwrite("~s:~w: ~w: ~w~n",[File,Line,Type,Err])
    end,
    print(More);
print(String) ->
    io:fwrite("~s~n",[String]).
    
