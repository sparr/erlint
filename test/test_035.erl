u() ->
                  case foo of
                      1 ->
                          A = 1,
                          B = 2,
                          W = 3, % W unused.
                          Z = 3; % Z unused.
                      2 ->
                          B = 2,
                          Z = 4 % Z unused.
                  end,
                  case bar of
                      true ->
                          A = 17, % A unsafe.
                          X = 3, % X unused.
                          U = 2,
                          U;
                      false ->
                          B = 19, % B exported.
                          U = 3; % U unused.
                      foo ->
                          X = 3,
                          X;
                      bar ->
                          X = 9, % X unused.
                          U = 14 % U unused.
                  end.
           

