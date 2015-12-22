-export([inline/0]).

             -import(lists, [a/1,b/1]). % b/1 is not used

             -compile([{inline,{inl,7}}]).    % undefined
             -compile([{inline,[{inl,17}]}]). % undefined
             -compile([{inline,{inl,1}}]).    % OK

             foop() ->   % unused function
                 a([]),  % used import, OK
                 fipp(). % undefined

             inline() ->
                 inl(foo).

             inl(_) ->
                 true.

             not_used() ->      % unused function
                 true.

             -compile({nowarn_unused_function,[{and_not_used,2}]}). % unknown 
             and_not_used(_) -> % unused function
                 foo.

             -compile({nowarn_unused_function,{unused_function,2}}).
             unused_function(_, _) ->
                 ok.
           

