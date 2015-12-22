t(A) when erlang:is_foobar(A) -> ok;
          t(A) when A ! ok -> ok;
          t(A) when A ++ [x] -> ok.

