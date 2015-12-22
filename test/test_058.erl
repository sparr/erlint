foo1(X) ->
                Try = 
                  try R=self()
                  catch
                    Class:Data -> Rc={X,R,Class,Data}
                  end,
                {X,Try,Rc}.
          foo2(X) ->
                Try = 
                  try R=self() of
                    RR -> Ro={X,R,RR}
                  catch
                    Class:Data -> {X,R,RR,Ro,Class,Data}
                  end,
                {X,Try,R,RR,Ro,Class,Data}.
          foo3(X) ->
                Try = 
                  try R=self() of
                    RR -> {X,R,RR}
                  catch
                    Class:Data -> {X,R,RR,Class,Data}
                  after
                    Ra={X,R,RR,Class,Data}
                  end,
                {X,Try,R,RR,Ra,Class,Data}.
           

