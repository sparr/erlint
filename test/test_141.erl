-module(lint_test).
              -export([t/0]).
              t() ->
                  case x() of
                      _ when l() 
                             or
                             l() ->
                          foo
                  end.
             

