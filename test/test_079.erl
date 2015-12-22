t() ->
                  U = 8, 
                  (fun(<<U: % U shadowed.
                          U>>) -> U end)(<<32:8>>).
             

