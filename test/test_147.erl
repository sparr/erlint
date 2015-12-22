-module(otp_6885).
            -export([t/1]).
            t(<<_/binary,I>>) -> I;
            t(<<X/binary,I:X>>) -> I;
        t(<<B/binary,T/binary>>) -> {B,T}.

            build(A, B) ->
               <<A/binary,B/binary>>.

            foo(<<\"abc\"/binary>>) ->
               ok;
            foo(<<\"abc\":13/integer>>) ->
               ok;
            foo(<<\"abc\"/float>>) ->
               ok;
            foo(<<\"abc\":19>>) ->
               ok;
            foo(<<\"abc\"/utf8>>) ->
               ok;
            foo(<<\"abc\"/utf16>>) ->
               ok;
            foo(<<\"abc\"/utf32>>) ->
               ok.

           

