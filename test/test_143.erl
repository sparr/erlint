-module(lint_test).
                -export([t/0]).
                -record(u1, {a}).
                -record(u2, {a = #u1{}}).
                -record(u3, {a}). % unused
                -record(u4, {a = #u3{}}). % unused

                t() ->
                    {#u2{}}.
               

