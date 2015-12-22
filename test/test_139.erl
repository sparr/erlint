-module(lint_test).
              -include_lib(\"stdlib/include/qlc.hrl\").
              -export([t/0]).
              -record(r1, {a = qlc:e(qlc:q([X || X <- [1,2,3]]))}).
              -record(r2, {a = qlc:q([X || X <- [1,2,3]])}).
              -record(r3, {a = qlc:q([X || {A,Y} <- [{1,2},V={3,4}],
                                           begin Z = [1,2,3], true end,
                                           X <- Z ++ [A,Y]])}).
              t() -> {#r1{},#r2{},#r3{}}.
             

