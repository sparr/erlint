-record(r, {a,b}).
              f(X, Y) -> #r{a=[K || K <- Y], b=[K || K <- Y]}.
              g(X, Y) -> #r{a=lists:map(fun (K) -> K end, Y),
                            b=lists:map(fun (K) -> K end, Y)}.
              h(X, Y) -> #r{a=case Y of _ when is_list(Y) -> Y end,
                            b=case Y of _ when is_list(Y) -> Y end}.
              i(X, Y) -> #r{a=if is_list(Y) -> Y end, b=if is_list(Y) -> Y end}.
             

