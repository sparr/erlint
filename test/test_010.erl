f(A) ->
                  B = foo,
                  [B || B <- A], % B shadowed.
                  B.
           

