-record(apa, {}).
              t(A) when atom(A) ->
                  atom;
              t(A) when binary(A) ->
                  binary;
              t(A) when constant(A) ->
                  constant;
              t(A) when float(A) ->
                  float;
              t(A) when function(A) ->
                  function;
              t(A) when integer(A) ->
                  integer;
              t(A) when is_atom(A) ->
                  is_atom;
              t(A) when is_binary(A) ->
                  is_binary;
              t(A) when is_constant(A) ->
                  is_constant;
              t(A) when is_float(A) ->
                  is_float;
              t(A) when is_function(A) ->
                  is_function;
              t(A) when is_integer(A) ->
                  is_integer;
              t(A) when is_list(A) ->
                  is_list;
              t(A) when is_number(A) ->
                  is_number;
              t(A) when is_pid(A) ->
                  is_pid;
              t(A) when is_port(A) ->
                  is_port;
              t(A) when is_record(A, apa) ->
                  is_record;
              t(A) when is_record(A, apa, 1) ->
                  is_record;
              t(A) when is_reference(A) ->
                  is_reference;
              t(A) when is_tuple(A) ->
                  is_tuple;
              t(A) when list(A) ->
                  list;
              t(A) when number(A) ->
                  number;
              t(A) when pid(A) ->
                  pid;
              t(A) when port(A) ->
                  port;
              t(A) when record(A, apa) ->
                  record;
              t(A) when reference(A) ->
                  reference;
              t(A) when tuple(A) ->
                  tuple.
           

