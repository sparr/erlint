t() ->
                 A = 4, % unused
                 fun(<<A:8, % shadowed
                       16:A>>) -> 2 end.
             

