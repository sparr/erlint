-record(r1, {a = fun(<<X:8>>) -> X end,
                           b = case <<17:8>> of
                                   <<_:Y>> -> Y;
                                   <<Y:8>> -> 
                                       Y
                               end}).
              t() -> #r1{}.
             

