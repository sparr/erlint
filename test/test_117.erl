-record(foo, {a,b,c}).
              -record(bar, {x,y,z}).
              -record(buzz, {x,y}).
              a(#foo{a = <<X:8>>,b=x} = #foo{b = <<Y:8>>}) ->
                  {X,Y}.
              b(#foo{a = <<X:8>>} = #bar{y = <<Y:4,Z:4>>}) ->
                  {X,Y,Z}.
              c(#foo{a = <<X:8>>} = #buzz{y = <<Y:8>>}) ->
                  {X,Y}.
             

