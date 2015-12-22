-record(r1, {a = fun(NotShadowing) -> NotShadowing end}).
              t() ->
                  NotShadowing = 17,
                  {#r1{}, NotShadowing}.
             

