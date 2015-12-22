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

strip_newlines(Str) -> [ C || C <- lists:flatten(Str), C /= 10 ].

% degenerate case
print([]) ->
    0;
print([{Type,File,{Line,Mod,Err}}|More]) ->
    io:fwrite("~s:~w: ~w: ~s~n",[File,Line,Type,strip_newlines(Mod:format_error(Err))]),
    print(More);
print(String) ->
    io:fwrite("~s~n",[String]).
