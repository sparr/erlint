
              -export([b2/1]).
              -behaviour(callback1).
              -behaviour(callback2).

              -spec b2(integer()) -> atom().
              b2(I) when is_integer(I)->
                  a.
             

