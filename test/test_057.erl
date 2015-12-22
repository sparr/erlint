foo1a() ->
                Try = 
                  try self()
                  catch
                    Class:Data -> Rc={Class,Data}
                  after
                    Ra=ok
                  end,
                {Try,Rc,Ra}.
              foo1b() ->
                Try = 
                  try self() of
                    R -> R
                  catch
                    Class:Data -> Rc={Class,Data}
                  after
                    Ra=R
                  end,
                {Try,Rc,Ra}.
              foo2() ->
                Try = 
                  try self() of
                    R -> Ro=R
                  catch
                    Class:Data -> {Class,Data}
                  after
                    Ra=R
                  end,
                {Try,Ro,Ra}.
              foo3() ->
                Try = 
                  try self() of
                    R -> Ro=R
                  catch
                    Class:Data -> Rc={Class,Data}
                  after
                    Ra=R
                  end,
                {Try,R,Ro,Rc,Ra}.
           

