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

stringify_term(Term) ->
    case io_lib:printable_list(Term) of
        true ->
            io_lib:format("~s",[Term]);
        false ->
            io_lib:format("~w",[Term])
    end.

% degenerate case
print([]) ->
    0;
print([{Type,File,{Line,_Mod,Err}}|More]) ->
    io:fwrite("~s:~w: ~w: ",[File,Line,Type]),
    case Err of
        {Cat,TermA,TermB,String} ->
            io:fwrite("~w (~w,~w) ~s",[Cat,TermA,TermB,String]);
        {Cat,{Mod,Fun,Arity},Description} ->
            io:fwrite("~w ~w:~w/~w (~s)",[Cat,Mod,Fun,Arity,Description]);
        {Cat,Term,{Block,BlockLine}} ->
            io:fwrite("~w ~w ~w@~w",[Cat,Term,Block,BlockLine]);
        {Cat,Term,Member} ->
            io:fwrite("~w ~w.~w",[Cat,Term,Member]);
        {Cat,{Fun,Arity}} ->
            io:fwrite("~w ~w/~w",[Cat,Fun,Arity]);
        {Cat,Term} ->
            io:fwrite("~w ~s",[Cat,stringify_term(Term)]);
        Err ->
            io:fwrite("~s",[stringify_term(Err)])
    end,
    io:nl(),
    print(More);
print(String) ->
    io:fwrite("~s~n",[String]).
