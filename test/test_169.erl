-export([x/1]).
              -import(x,[abs/1]).
              x(X) ->
                 binary_part(X,{1,2}).
             

