t() ->
                  X = {foo},
                  is_record(X, foo),
                  erlang:is_record(X, foo),
                  {erlang,is_record}(X, foo),
                  %% Note: is_record/3 does not verify that the record is defined,
                  %% so the following lines should give no errors.
                  is_record(X, foo, 1),
                  erlang:is_record(X, foo, 1),
                  {erlang,is_record}(X, foo, 1).
             

