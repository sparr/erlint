t() ->
                 L = 16,
                 fun(<<L: % shadow
                       L>>, % 'outer' L
                     <<L: % shadow and match
                       L>>) -> % 'outer' L
                         a
                 end.
             

