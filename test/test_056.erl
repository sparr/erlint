foo2() ->
                try self()
                catch
                  Class:Data -> Result={Class,Data}
                end,
                Result.
              foo3a() ->
                try self() of
                  R -> R
                catch
                  Class:Data -> Result={Class,Data}
                end,
                Result.
              foo3b() ->
                try self() of
                  Result -> ok
                catch
                  Class:Data -> {Class,Data}
                end,
                Result.
           

