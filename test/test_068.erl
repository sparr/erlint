-record(apa,{}).
               t() ->
               [X || X <- [1,#apa{},3], (3+is_record(X, apa)) or 
                                        (is_record(X, apa)*2)].
            

