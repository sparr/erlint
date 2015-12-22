-module(lint_test).
              -import(qlc, [q/2]).
              -export([t/0]).

              t() ->
                  H1 = qlc:q([X || X <- [1,2]]),
                  H2 = qlc:q([X || X <- [1,2]], []),
                  H3 = q([X || X <- [1,2]], []),
                  {H1,H2,H3}.
             

