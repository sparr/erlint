t(<<X:bad_size>>) -> X;
          t(<<_:(x ! y)/integer>>) -> ok;
              t(<<X:all/integer>>) -> X;
              t(<<X/bad_type>>) -> X;
          t(<<X/unit:8>>) -> X;
          t(<<X:7/float>>) -> X;
          t(<< <<_:8>> >>) -> ok;
          t(<<(x ! y):8/integer>>) -> ok;
              t(X) ->
                {<<X/binary-integer>>,<<X/signed-unsigned-integer>>,
                 <<X/little-big>>,<<X/unit:4-unit:8>>}.
        

