-module(erlint).
-export([main/1]).

main(["--version"]) ->
    io:fwrite("erlint version 0.1.0~n");
main([File]) -> % escript passes in args in an array
    Out = lint(File),
    print(Out);
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
                {ok, [Warnings]} ->
                    [{warning,element(1,Warnings),X} || X <- element(2,Warnings)];
                % errors, no warnings
                {error, [Errors], []} ->
                    [{error,element(1,Errors),X} || X <- element(2,Errors)];
                % errors and warnings
                {error, [Errors], [Warnings]} ->
                    [{error,element(1,Errors),X} || X <- element(2,Errors)] ++
                    [{warning,element(1,Warnings),X} || X <- element(2,Warnings)]
            end;
        {error, _} ->
            "Cannot open file"
    end.

% degenerate case
print([]) ->
    0;
% some errors use a tuple to describe the error
print([{Type,File,{Line,_Module,{ErrT,ErrX}}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w ~w~n",[File,Line,Type,ErrT,ErrX]),
    print(More);
% some errors use a list to describe the error
print([{Type,File,{Line,_Module,[ErrT,ErrX]}}|More]) ->
    io:fwrite("~s:~w: ~w: ~s ~s~n",[File,Line,Type,ErrT,ErrX]),
    print(More);
% some errors use a string to describe the error
print([{Type,File,{Line,_Module,Err}}|More]) ->
    io:fwrite("~s:~w: ~w: ~s~n",[File,Line,Type,Err]),
    print(More);
print(String) ->
    io:fwrite("~s~n",[String]).
    
