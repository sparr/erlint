-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              x(X) when binary_part(X,{1,2}) =:= <<1,2>> ->
                 hej.
              binary_part({B,_},{X,Y}) ->
                binary_part(B,{X,Y});
              binary_part(B,{X,Y}) ->
                binary:part(B,X,Y).
             

