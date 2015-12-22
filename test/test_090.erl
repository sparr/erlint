t() ->
                 L = 4,      % L unused
                 fun({L,     % L shadowed
                      L},
                     {L,
                      L}) ->
                         a
                 end.
             

