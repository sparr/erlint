-export([binary_port/3]).
              -compile({no_auto_import,[binary_part/3]}).
              -import(x,[binary_part/3]).
              binary_port(A,B,C) when x:binary_part(A,B,C) ->
                 binary_part(A,B,C+1).
             

