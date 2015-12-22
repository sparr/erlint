t9(X) ->
                  case X of
                      1 ->
                          catch A = 1, % unsafe only here
                          B = 1,
                          C = 1,
                          D = 1;
                      2 ->
                          A = 2,
                          % B not bound here
                          C = 2,
                          catch D = 2; % unsafe in two clauses
                      3 ->
                          A = 3,
                          B = 3,
                          C = 3,
                          catch D = 3; % unsafe in two clauses
                      4 ->
                          A = 4,
                          B = 4,
                          C = 4,
                          D = 4
                  end,
                  {A,B,C,D}.

