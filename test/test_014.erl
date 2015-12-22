j({X}) ->
                  [Z || Z <- X, % Z unused.
                        Z <- X = [[1,2,3]], % Z shadowed. Z unused.
                        Z <- X, % Z shadowed. Z unused.
                        Z <- X]; % Z shadowed.
              j(X) ->
                  [foo || X <- X, % X shadowed.
                        X <-    % X shadowed. X unused.
                             X = 
                                 Y = [[1,2,3]], % Y unused.
                        X <- [], % X shadowed.
                        X <- X]. % X shadowed. X unused.
           

