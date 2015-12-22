f8(A) ->
                  <<A:8/utf8>>.
              g8(A) ->
                  <<A:8/utf8-unit:1>>.
              h8(A) ->
                  <<A/utf8-unit:1>>.

              f16(A) ->
                  <<A:8/utf16>>.
              g16(A) ->
                  <<A:8/utf16-unit:1>>.
              h16(A) ->
                  <<A/utf16-unit:1>>.

              f32(A) ->
                  <<A:8/utf32>>.
              g32(A) ->
                  <<A:8/utf32-unit:1>>.
              h32(A) ->
                  <<A/utf32-unit:1>>.
             

