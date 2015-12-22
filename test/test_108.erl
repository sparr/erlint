-export([spawn/1]).
              -compile({nowarn_deprecated_function,{erlang,hash,2}}).
              -compile({nowarn_bif_clash,{spawn,1}}).
              -compile({nowarn_bif_clash,{spawn,2}}). % bad
              -compile([{nowarn_deprecated_function, 
                                [{erlang,hash,-1},{3,hash,-1}]}, % 2 bad
                     {nowarn_deprecated_function, {{a,b,c},hash,-1}}]). % bad
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           

