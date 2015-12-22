t() ->
                 A = 4,
                 fun(<<8:A, % 
                       A:8>>) -> 7 end. % shadowed, unused
             

