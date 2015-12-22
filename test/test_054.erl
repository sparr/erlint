foo(State) ->
                  case State of
                      true ->
                          if
                              false -> ok;
                              true ->  State1=State
                          end
                  end,
                  State1. % unsafe
           

