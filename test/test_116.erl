-record(foo, {a,b,c}).
              -record(bar, {x,y,z}).
              -record(buzz, {x,y}).
              a(#foo{a = <<X:8>>} = #bar{x = <<Y:8>>}) ->
                  {X,Y}.
              b(#foo{b = <<X:8>>} = #foo{b = <<Y:4,Z:4>>}) ->
                  {X,Y,Z}.
              c(#foo{a = <<X:8>>} = #buzz{x = <<Y:8>>}) ->
                  {X,Y}.
              d(#foo{a=x,b = <<X:8>>} = #buzz{y = <<Y:8>>}) ->
                  {X,Y}.
              e(#foo{a=x,b = <<X:8>>} = #buzz{x=glurf,y = <<Y:8>>}) ->
                  {X,Y}.
             

