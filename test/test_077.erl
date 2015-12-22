t() ->
                 L = 8,
                 F = fun(<<L: % L shadowed.
                            L,
                           B:
                            L>>) -> B end,
                 F(<<16:8, 7:16>>).
             

