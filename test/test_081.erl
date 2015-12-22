t() ->
                  L = 8,
                  F = fun(<<L: % Shadow.
                           L,
                           L:
                           L,
                           L:
                           L
                           >>) ->
                              L
                      end,
                  F(<<16:8, 8:16, 32:8>>).
             

