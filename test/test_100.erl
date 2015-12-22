-compile(export_all).

             -record(r, {}).

             f(A) when list(A) -> list;
             f(R) when record(R, r) -> rec;
             f(P) when pid(P) -> pid.

             t() ->
                 f([]).
            

