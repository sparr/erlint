-export([x/1]).
              -import(x,[binary_port/3]).
              -import(y,[binary_port/3]).
              x(X) ->
                 abs(X).
             

