
            -module(map).

            -compile(export_all).

            -export_type([map/0, product/0]).

            -opaque map() :: dict().

            -spec t() -> map().

            t() ->
                1.
         

