t() ->
                 fun(<<Type:16, _Len:16, Value:_Len/binary>>) ->
                     {Type, Value}
                 end.
             

