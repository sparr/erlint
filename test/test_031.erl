t1() ->
                  UnusedVar1 = unused1,
                  try
                      UnusedVar2 = unused2
                  catch
                      _:_ ->
                          ok
                  end,
                  ok.
           

