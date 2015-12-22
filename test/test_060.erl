bang() ->
                case 1 of
                  nil ->
                    Acc = 2;
                  _ ->
                    try
                      Acc = 3,
                      Acc
                    catch _:_ ->
                      ok
                    end
                end,
                Acc.
           

