t(Val) ->
                  (<<A:8>> = X) = (Y = <<B:8>>) = Val,
                  {A,B,X,Y}.
             

