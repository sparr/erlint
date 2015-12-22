lc3() ->
                  Z = [1,2,3], 
                  [X || X <- Z, 
                        Z <- Z]. % Z shadowed. Z unused.
           

