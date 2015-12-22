t(X) ->
                  size(X).

              %% No warning for the following calls, since they
              %% are unambigous.
              b(X) ->
                  erlang:size(X).

              c(X) ->
                  ?MODULE:size(X).

              size({N,_}) ->
                N.
             

