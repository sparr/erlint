t() ->
                 A = 4,
                 fun(<<A: % shadowed, unused
                       A>>) -> 2 end.
             

