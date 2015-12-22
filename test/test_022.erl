c({I1,I2}) ->
                  if
                      <<I1:I2>> == <<>> ->
                          foo
                  end;
              c([C1,C2]) -> % C1 unused.
                  case foo of
                      <<C2:C2,
                        C3:C2>> -> % C3 unused.
                          bar
                  end.

           

