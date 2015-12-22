bin([X]) ->
                  [A || <<A:X>> <- []]; % X used, not shadowed.
              bin({X}) ->
                  [X || <<X:X>> <- []]; % X used, and shadowed.
              bin({X,Y,Z}) ->
                  [{A,B} || <<A:X>> <- Z, <<B:Y>> <- Z];
              bin([X,Y,Z]) -> % Y unused.
                  [C || <<V:X>> <- Z, <<B:V>> <- Z, <<C:B>> <- Z].
           

