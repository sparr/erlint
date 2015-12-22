i(X) ->
                  [Z || Z <- X, % Z unused.
                        Z = X <- [foo]]. % X and Z shadowed. X unused!
           

