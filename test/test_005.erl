a([A]) ->
                  B = foo,
                  [{C,B} || {C,_} <- A];
              a({A}) ->
                  B = foo,
                  [C || {C,_} <- [B,A]];
              a({A,A}) ->
                  B = foo,
                  [C || {C,_} <- B, B < A].
           

