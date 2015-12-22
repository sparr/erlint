-export([x/1]).
              -import(x,[binary_port/3]).
              binary_port(A,B,C) ->
                 binary_part(A,B,C).
              x(X) ->
                 abs(X).
             

