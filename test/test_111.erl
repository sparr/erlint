-compile({nowarn_deprecated_function,{erlang,hash,2}}).
              -compile({nowarn_bif_clash,{spawn,1}}).
              -import(x,[spawn/1]).
              spin(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           

