t() ->
                  _ = (catch MS = MS = 1), % MS used unsafe
                  _ = case ok of _ -> fun() -> ok end end,
                  fun (MS) -> MS end. % MS not shadowed here
           

