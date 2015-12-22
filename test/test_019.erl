bin(Z) ->
                  %% This used to pass erl_lint...
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
                          Y = 3; % Y unused.
                      false ->
                          4
                  end,
                  [Z || <<U:X>> <- Z], % (X exported.) U unused.
                  U. % U unsafe.
           

