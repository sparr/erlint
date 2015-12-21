-module(erlint).
-export([main/1]).

main(["--version"]) ->
    io:fwrite("erlint version 0.1.0~n");
main([File]) -> % escript passes in args in an array
    Compare = fun({_,File1,{Line1,_,Err1}},{_,File2,{Line2,_,Err2}}) ->
        {File1,Line1,Err1} =< {File2,Line2,Err2} end,
    print(lists:sort(Compare,lint(File)));
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
                    {WFile,WList} = Warnings,
                    [{warning,WFile,Warning} || Warning <- WList];
                % errors, no warnings
                {error, [Errors], []} ->
                    {EFile,EList} = Errors,
                    [{error,EFile,Error} || Error <- EList];
                % errors and warnings
                {error, [Errors], [Warnings]} ->
                    {WFile,WList} = Warnings,
                    {EFile,EList} = Errors,
                    [{error,EFile,Error} || Error <- EList] ++
                    [{warning,WFile,Warning} || Warning <- WList]
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
    
