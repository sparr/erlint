t() ->
                 [{Type, Value} || <<Type:16, _Len:16, 
                                    Value:_Len/binary>> <- []].
             

