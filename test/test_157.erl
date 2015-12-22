-export([size/1]).
              size({N,_}) ->
                N;
              size(X) ->
                erlang:size(X).
             

