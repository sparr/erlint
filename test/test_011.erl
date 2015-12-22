g(A) ->
                  B = foo, % B unused.
                  [A || B <- A]. % B shadowed, B unused.
           

