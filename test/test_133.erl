-record(r1, {a = {A, % A unbound
                                A}}). % A unbound
              -record(r2, {a = begin case foo of 
                                         A -> A
                                     end,
                                     A
                                end}).
              -record(r3, {a = fun(X) ->
                                       case foo of
                                           A -> A
                                       end
                               end
                          }).
              -record(r4, {a = case foo of
                                   foo ->
                                       case foo of
                                           A -> A
                                       end;
                                   _ -> 
                                       bar
                               end}).
              t() -> {#r1{},#r2{},#r3{},#r4{}}.
             

