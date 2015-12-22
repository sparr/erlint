-record(apa, {}).
               t3(A) when record(A, {apa}) ->
                   foo;
               t3(A) when is_record(A, {apa}) ->
                   foo;
               t3(A) when erlang:is_record(A, {apa}) ->
                   foo;
               t3(A) when is_record(A, {apa}, 1) ->
                   foo;
               t3(A) when erlang:is_record(A, {apa}, 1) ->
                   foo;
               t3(A) when is_record(A, apa, []) ->
                   foo;
               t3(A) when erlang:is_record(A, apa, []) ->
                   foo;
               t3(A) when record(A, apa) ->
                   foo;
               t3(A) when is_record(A, apa) ->
                   foo;
               t3(A) when erlang:is_record(A, apa) ->
                   foo.
            

