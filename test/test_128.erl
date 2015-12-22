-record(c, {a = fun ?MODULE:i/1(17)}).
              t() ->
                  #c{}.

              i(X) ->
                  X.
            

