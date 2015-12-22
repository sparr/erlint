-export([size/1]).
              size({N,_}) ->
                N;
              size(X) ->
                size(X).
             

