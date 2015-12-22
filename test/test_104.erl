-record(a, {x,
                          x}).
              -record(a, {x,
                          X}). % erl_parse
              -record(a, [x,
                          x]). % erl_parse
              -record(ok, {a,b}).

              -record(r, {a = #ok{}, 
                          b = (#ok{})#ok.a}).

              t() ->
                  {#a{},
                   #nix{},
                   #ok{nix = []},
                   #ok{Var = 4}, 
                   #r{}
                  }.
           

