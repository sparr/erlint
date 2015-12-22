-export([size/1]).
              -compile({no_auto_import,[size/1]}).
              size([]) ->
                0;
              size({N,_}) ->
                N;
              size([_|T]) ->
                1+size(T).
             

