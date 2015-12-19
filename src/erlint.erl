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
                {ok, []} ->
                    [];
                {ok, [Warnings]} ->
                    [{warning,element(1,Warnings),X} || X <- element(2,Warnings)];
                {error, [Errors], [Warnings]} ->
                        [{error,element(1,Errors),X} || X <- element(2,Errors)] ++
                        [{warning,element(1,Warnings),X} || X <- element(2,Warnings)]
            end;
        {error, _} ->
            "Cannot open file"
    end.

print([]) ->
    0;
print([{Type,File,{Line,_Module,Err}}|More]) ->
    io:fwrite("~s:~w: ~w: ~w~n",[File,Line,Type,Err]),
    print(More);
print(String) ->
    io:fwrite("~s~n",[String]).
    
