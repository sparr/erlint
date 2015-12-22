-compile({inline, [{f,3},{f,4},{f,2},{f,a},{1,foo}]}).
              -compile({inline, {g,1}}).
              -compile({inline, {g,12}}).
              -compile(inline).
              -compile({inline_size,100}).

              f(A, B) ->
                  {g(A), B}.

              g(A) ->
                  {A}.
             

