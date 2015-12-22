-include_lib(\"stdlib/include/qlc.hrl\").
              -record(a, {x = qlc:q([{X,Y} || {X} <- [],{Y} <- [],X =:= Y])}).
              -export([t/0]).              
              t() -> #a{}.
          

