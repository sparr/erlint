h(A) ->
                  B = foo,
                  [A || B <- A], % B shadowed, B unused.
                  B.
           

