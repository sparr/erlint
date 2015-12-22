objs(<<Size:4/unit:8, B:Size/binary>>) ->
                  B.

              fel(<<Size:4/unit:8, B:BadSize/binary>>) -> % BadSize unbound.
                  BadSize.                                % B, Size unused.

              r9c_highlight() -> % B, Rest unused.
                 <<Size, B:Size/binary,Rest/binary>> = <<2,\"AB\",3,\"CDE\

