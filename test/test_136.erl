-record(r, {a = [X || {A,Y} <- [{1,2},V={3,4}],
                                    begin Z = [1,2,3], true end,
                                    X <- Z ++ [A,Y]]}).
              t() ->#r{}.
             

