-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              -import(erlang,[binary_part/2]).
              x(X) when binary_part(X,{0,1}) =:= <<0>> ->
                 binary_part(X,{1,2}) =:= <<1,2>>.
             

