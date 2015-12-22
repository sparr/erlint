bin(A) ->
                  receive
                      M ->
                           X = M,
                           Y = M,
                           Z = M
                  end,
                  [B || <<B:X>> <- A], % X exported.
                  Y = B, % Y exported. B unbound.
                  [B || B <- Z]. % Z exported. B shadowed.
           

