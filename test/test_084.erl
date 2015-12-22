t([A,B]) ->
                 fun(<<A:B>>, % A shadowed and unused
                     <<Q:A>>) -> foo % Q unused. 'outer' A is used.
                 end.
             

