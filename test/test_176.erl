-export([size/1, binary_part/2]).
             -compile(no_auto_import).
             size([]) ->
               0;
             size({N,_}) ->
               N;
             size([_|T]) ->
               1+size(T).
             binary_part({B,_},{X,Y}) ->
               binary_part(B,{X,Y});
             binary_part(B,{X,Y}) ->
               binary:part(B,X,Y).
            

