-export([binary_port/3]).
              -import(x,[binary_part/3]).
              binary_port(A,B,C) ->
                 binary_part(A,B,C).
             

