-export([t/1]).
              t(L) ->
                 lists:map(fun(X) -> 2*X end, L).

              fact(N) ->
                fact_1(N, 1).

              fact_1(1, P) -> P;
              fact_1(N, P) -> fact_1(N-1, P*N).
           

