-export([a/1, b/1, t/0]).

            -callback b(_) -> integer().

            -callback ?MODULE:a(_) -> integer().

            a(_) -> 3.

            b(_) -> a.

            t()-> a.
    

