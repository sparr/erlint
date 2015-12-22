a({A,B}) -> % A unused.
                  fun(A) -> B end; % A shadowed. A unused.
              a([A,B]) ->
                  fun(<<A:B>>, % A shadowed. A unused.
                       <<Q:A>>) -> foo % Q unused.
                  end;
              a({A,B,C,D,E}) ->
                  fun(E) when C == <<A:A>>, <<17:B>> == D -> % E shadowed. E unused.
                          foo
                  end,
                  E;
              a([A,B,C,D,E]) -> % E unused.
                  fun() ->
                          (C == <<A:A>>) and (<<17:B>> == D)
                  end.
           

