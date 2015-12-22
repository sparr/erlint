t() ->
                  #{ a := b,
                     c => d,
                     e := f
                  }#{ a := b,
                      c => d,
                      e := f };
              t() when is_map(#{ a := b,
                                 c => d
                              }#{ a := b,
                                  c => d,
                                  e := f }) ->
                  ok.
            

