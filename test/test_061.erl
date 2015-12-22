t({bc,binary,Bin}) ->
          << <<X,Tail/binary>> || <<X,Tail/binary>> <= Bin >>;
          t({bc,bits,Bin}) ->
          << <<X,Tail/bits>> || <<X,Tail/bits>> <= Bin >>;
          t({bc,bitstring,Bin}) ->
          << <<X,Tail/bits>> || <<X,Tail/bitstring>> <= Bin >>;
          t({lc,binary,Bin}) ->
          [ {X,Tail} || <<X,Tail/binary>> <= Bin ];
          t({lc,bits,Bin}) ->
          [ {X,Tail} || <<X,Tail/bits>> <= Bin ];
          t({lc,bitstring,Bin}) ->
          [ {X,Tail} || <<X,Tail/bitstring>> <= Bin ].

