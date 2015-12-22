-compile(nowarn_deprecated_function).
              -compile(nowarn_bif_clash).
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           

