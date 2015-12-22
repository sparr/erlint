t([A,B]) -> % A unused, B unused
                 fun({A,B}, % A shadowed, B unused, B shadowed
                     {Q,A}) -> foo % Q unused. 'inner' A is used
                 end.
             

