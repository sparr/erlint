
              -export([b1/1]).
              -behaviour(callback1).
              -behaviour(callback2).

              -spec b1(atom()) -> integer().
              b1(A) when is_atom(A)->
                  3.
             

