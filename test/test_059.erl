foo1(X) ->
                Try = 
                  try R=self() of
                    RR -> Ro={X,R,RR}
                  catch
                    Class:Data -> Rc={X,R,RR,Ro,Class,Data}
                  after
                    Ra={X,R,RR,Ro,Rc,Class,Data}
                  end,
                {X,Try,R,RR,Ro,Rc,Ra,Class,Data}.
           

