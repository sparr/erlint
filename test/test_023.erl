t() ->
                  S = 8,
                  case <<3:8>> of
                      <<X:S>> ->
                          X;
                      <<S:X>> -> % X unbound
                          foo
                  end;
              t() ->
                  S = 8,
                  case <<3:8>> of
                      <<S:S>> ->
                          S;
                      <<Q:32>> -> % Q unused.
                          foo
                  end.
           

