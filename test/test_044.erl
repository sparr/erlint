-export([t/1]).
              -compile(nowarn_unused_function).

              t(L) ->
                 lists:map(fun(X) -> 2*X end, L).

              b(X) ->
                32*X.
           

