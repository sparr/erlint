b(A) ->
                  B = foo, % B unused.
                  [C || {C,_} <- A].
           

