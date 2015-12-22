-export([is_list/1]).
              -import(x, [is_tuple/1]).
              -record(r, {a,b}).
              x(T) when is_tuple(T) -> ok;
              x(T) when is_list(T) -> ok.
              y(T) when is_tuple(T) =:= true -> ok;
              y(T) when is_list(T) =:= true -> ok;
              y(T) when is_record(T, r, 3) -> ok;
              y(T) when is_record(T, r, 3) =:= true -> ok;
              y(T) when is_record(T, r) =:= true -> ok.
              is_list(_) ->
                ok.
              is_record(_, _) ->
                ok.
              is_record(_, _, _) ->
                ok.
             

