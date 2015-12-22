-record(edge,
                      {ltpr,
                       ltsu,
                       rtpr,
                       rtsu
                      }).

              f1(#edge{ltpr = A, ltsu = A}) ->
                  true;
              f1({Q, Q}) ->
                  true.

              f2(Edge, Etab) ->
                  case gb_trees:lookup(Edge, Etab) of
                      {value,#edge{ltpr=Same,ltsu=Same}} -> ok;
                      {value,_} -> error
                  end.

              bar(Edge, Etab) ->
                  case gb_trees:lookup(Edge, Etab) of
                      {Same,Same} -> ok;
                      {value,#edge{ltpr=Same}} -> ok; % Same unused.
                      {value,_} -> error
                  end.
           

