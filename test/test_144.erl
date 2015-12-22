-module(lint_test).
                -export([t/0]).
                -record(u1, {a}).
                -record(u2, {a = #u1{}}).
                -file(\"some_file.hrl\", 1).
                -record(u3, {a}). % unused, but on other file
                -record(u4, {a = #u3{}}). % -\"-

                t() ->
                    {#u2{}}.
               

