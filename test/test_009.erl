e(A) ->
                  B = foo, % B unused.
                  [B || B <- A]. % B shadowed.
           

