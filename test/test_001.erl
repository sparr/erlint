f(F) -> % F unused.
                ok.

            f(F, F) ->
                ok.

            g(_X) ->
                y.

            h(P) ->
                P.

            x(N) ->
                case a:b() of
                    [N|Y] -> % Y unused.
                        ok
                end.

            y(N, L) ->
                lists:map(fun(T) -> T*N end, L).

            z(N, L) -> % N unused
                lists:map(fun(N, T) -> T*N end, L).  % N shadowed.


            c(A) ->
                case A of
                    1 -> B = []; % B unused.
                    2 -> B = []; % B unused.
                    3 -> B = f, B
                end.
           

