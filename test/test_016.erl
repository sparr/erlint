lc2() ->
                  Z = [[1],[2],[3]], 
                  [X || Z <- Z, % Z shadowed.
                        X <- Z].
           

