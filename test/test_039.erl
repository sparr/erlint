bin(A) ->
                  receive
                      M ->
                           X = M,
                           Y = M,
                           Z = M
                  end,
                  [B || <<B:X>> <- A],
                  Y = B,
                  [B || B <- Z]. % B shadowed.
           

