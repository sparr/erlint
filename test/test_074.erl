t() ->
                 %% This one has always been handled OK:
                 <<Type:16, _Len:16, 
                      Value:_Len/binary>> = <<18:16, 9:16, \"123456789\

