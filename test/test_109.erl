-export([spawn/1]).
              -compile(warn_deprecated_function).
              -compile(warn_bif_clash).
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           

