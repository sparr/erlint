k(X) ->
                  [Z || Z <- Y = X]; % Y unused.
              k(X) ->
                  [Z || Z <- X = Y = X]; % Y unused!
              k(X) ->
                  [Z || Z <- begin X = Y = X, Y end];
              k(X) ->
                  [{Y,W} || W <- Y = X]; % Y unbound
              k(X) ->
                  [Z || Z <- (Y = X), % Y unused.
                       Y > X]; % Y unbound.
              k(X) ->
                  [Y || Y = X > 3, Z = X]; % Z unused.
              k(X) ->
                  [Z || Y = X > 3, Z = X]. % Y unused.
           

