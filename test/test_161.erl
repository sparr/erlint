-export([binary_part/2]).
              -compile({no_auto_import,[binary_part/2]}).
              binary_part({B,_},{X,Y}) ->
                binary_part(B,{X,Y});
              binary_part(B,{X,Y}) ->
                binary:part(B,X,Y).
             

