t() ->
                 L = 4,
                 [L || <<L: % shadowed
                         L, 
                         L:
                         L>> <- []].
             

