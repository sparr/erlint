t(Val) ->
                  (<<A:8>> = X) = (<<B:8>> = <<A:4,B:4>>) = Val,
                  {A,B,X}.
             

