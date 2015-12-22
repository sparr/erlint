-record(r1, {foo = A}). % A unbound
              -record(r2, {a = fun(X) -> X end(3)}).
              -record(r3, {a = [X || X <- [1,2,3]]}).
              t() -> {#r1{},#r2{},#r3{}}.
             

