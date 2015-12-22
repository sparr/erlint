t(V) -> #{ a => 1,
            #{a=>V} => 2,
            #{{a,V}=>V} => 2,
            #{ \"hi\" => wazzup, hi => ho } => yep,
            [try a catch _:_ -> b end] => nope,
            ok => 1.0,
            [3+3] => nope,
            1.0 => yep,
            {3.0+3} => nope,
            {yep} => yep,
            [case a of a -> a end] => nope
              }.
       

