-export([t/1,size/1]).
              t(X) ->
                  size(X).

              size({N,_}) ->
                N.

              %% My own abs/1 function works on lists too. From R14 this really works.
              abs([H|T]) when $a =< H, H =< $z -> [H-($a-$A)|abs(T)];
              abs([H|T]) -> [H|abs(T)];
              abs([]) -> [];
              abs(X) -> erlang:abs(X).
             

