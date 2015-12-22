-module(lint_test).
              -export([t/0]).
              -record(r, {a = true}).
              -record(r1, {a,b}).
              -record(r2, {a = #r1{a = true}}).
              -record(r3, {a = A}). % A is unbound
              -record(r4, {a = dict:new()}).

              t() ->
                  case x() of
                      _ when (#r{})#r.a ->
                          a; 
                      _ when (#r4{})#r.a -> % illegal
                          b;
                      _ when (#r3{q = 5})#r.a -> % no warning for unbound A
                          q;
                      _ when (#r{q = 5})#r.a ->
                          a; 
                      _ when (((#r{a = #r2{}})#r.a)#r2.a)#r1.a ->
                          b;
                      _ when #r{a = dict:new()} -> % illegal
                          c; 
                      _ when l() > 3 -> % illegal, does not use l/0...
                          d;
                      _ ->
                          w
                  end.

              l() ->
                  foo.

              x() ->
                  bar.
              

