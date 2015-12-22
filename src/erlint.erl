-module(erlint).
-export([main/1]).

main([]) ->
    getopt:usage(option_spec_list(), escript:script_name());
main(Args) ->
    OptSpecList = option_spec_list(),
    case getopt:parse(OptSpecList, Args) of
        {ok, {Options, _NonOptArgs}} ->
            dispatch_options(Options);
        {error, {Reason, Data}} ->
            io:format("Error: ~s ~p~n~n", [Reason, Data]),
            getopt:usage(OptSpecList, escript:script_name())
    end.

option_spec_list() ->
    [
  %% {Name,     ShortOpt,  LongOpt,       ArgSpec,               HelpMsg}
     {help,        $?,     "help",        undefined,             "Show the program options"},
     {version,     $v,     "version",     undefined,               "Show the program version"},
     {filename, undefined, undefined,     string,                "Name of file to lint"}
    ].

dispatch_options(Options) ->
    dispatch_options(Options,[]),
    ok.

dispatch_options([],_Acc) ->
    ok;
dispatch_options([help|_T],_Acc) ->
    getopt:usage(option_spec_list(), escript:script_name()),
    ok;
dispatch_options([version|_T],_Acc) ->
    io:format("Erlint version 0.2.0~n"),
    ok;
dispatch_options([{filename,File}|_T],_Acc) ->
    case lint(File) of
        {ok, Res} ->
            print(lists:sort(fun({_,F1,{L1,_,E1}},{_,F2,{L2,_,E2}}) -> {F1,L1,E1} =< {F2,L2,E2} end,Res));
        {error, Res} ->
            io:format("Error loading file: ~s~n",[file:format_error(Res)])
    end,
    ok;
%% Syntax for future usage with non-terminal options
%% Acc will contain all the skipped options when a terminal option is reached
% dispatch_options([{new_arg,Value}|T],Acc) ->
%     do_something(Value),
%     dispatch_options(T,[{new_arg,Value}|Acc]);
dispatch_options([_],_Acc) ->
    getopt:usage(option_spec_list(), escript:script_name()).

lint(File) ->
    case epp:parse_file(File,[]) of
        {ok, Forms} ->
            {ok,
                case erl_lint:module(Forms, File) of
                    {ok, []} -> % nothing wrong
                        [];
                    {ok, Warnings} -> % just warnings
                        [ {warning,WFile,Warning} || {WFile,WList} <- Warnings, Warning <- WList ];
                    {error, Errors, []} -> % just errors
                        [ {error,EFile,Error} || {EFile,EList} <- Errors , Error <- EList ];
                    {error, Errors, Warnings} -> % errors and warnings
                        [ {error,EFile,Error} || {EFile,EList} <- Errors , Error <- EList ] ++
                        [ {warning,WFile,Warning} || {WFile,WList} <- Warnings, Warning <- WList ]
                end
            };
        {error, Err} ->
            {error, Err}
    end.

strip_newlines(Str) -> re:replace(Str,"[\\n\\r]","",[global]).

% degenerate case
print([]) ->
    ok;
print([{Type,File,{Line,Mod,Err}}|More]) ->
    io:fwrite("~s:~w: ~w: ~s~n",[File,Line,Type,strip_newlines(Mod:format_error(Err))]),
    print(More);
print(String) ->
    io:fwrite("~s~n",[String]).
