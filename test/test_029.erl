u() ->
                  fun U() -> foo end, % U unused.
                  U; % U unbound.
              u() ->
                  case foo of
                      true ->
                          U = 2;
                      false ->
                          true
                  end,
                  fun U() -> foo end, % U unused.
                  U; % U unsafe.
              u() ->
                  case foo of
                      true ->
                          U = 2;
                      false ->
                          U = 3
                  end,
                  fun U() -> foo end, % U shadowed. U unused.
                  U;
              u() ->
                  case foo of
                      true ->
                          U = 2; % U unused.
                      false ->
                          U = 3 % U unused.
                  end,
                  fun U() -> foo end; % U shadowed. U unused.
              u() ->
                  fun U(U) -> foo end; % U shadowed. U unused.
              u() ->
                  fun U(1) -> U; U(U) -> foo end; % U shadowed. U unused.
              u() ->
                  fun _(N) -> N + 1 end.  % Cover handling of '_' name.
           

