-include_lib(\"stdlib/include/qlc.hrl\").

             -file(?FILE, 1000).

             t() ->
                 qlc:q([X || X <- [],
                             begin A = 3, true end]).
            

