bin(Z) ->
                  case bar of
                      true ->
                          U = 2;
                      false ->
                          true
                  end,
                  case bar of
                      true ->
                          X = 2;
                      false ->
                          X = 3
                  end,
                  case foo of
                      true ->
                          Y = 3;
                      false ->
                          4
                  end,
                  [B || <<U: % U unused
                          U>> <- X, <<B:Y>> <- Z]. % U unsafe. Y unsafe. 
                                                   % U shadowed. (X exported.)
           

