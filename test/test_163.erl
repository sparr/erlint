-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              x(X) ->
                 binary_part(X,{1,2}) =:= <<1,2>>.
             

