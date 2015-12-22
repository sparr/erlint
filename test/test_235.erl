-export([a/1]).

            -spec a(_A) -> boolean() when
                  _ :: atom(),
                  _A :: integer().

            a(_) -> true.
    

