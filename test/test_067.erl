-record(apa,{a=a,b=foo:bar()}).
              apa() ->
                 [X || X <- [], #apa{a = a} == {r,X,foo}];
              apa() ->
                 [X || X <- [], #apa{b = b} == {r,X,foo}];
              apa() ->
                 [X || X <- [], #ful{a = a} == {r,X,foo}].
            

