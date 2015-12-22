-record(apa,{}).
              t1(A) when atom(A), atom(A) ->
                  atom;
              t1(A) when binary(A), binary(A) ->
                  binary;
              t1(A) when constant(A), constant(A) ->
                  constant;
              t1(A) when float(A), float(A) ->
                  float;
              t1(A) when function(A), function(A) ->
                  function;
              t1(A) when integer(A), integer(A) ->
                  integer;
              t1(A) when is_atom(A), is_atom(A) ->
                  is_atom;
              t1(A) when is_binary(A), is_binary(A) ->
                  is_binary;
              t1(A) when is_constant(A), is_constant(A) ->
                  is_constant;
              t1(A) when is_float(A), is_float(A) ->
                  is_float;
              t1(A) when is_function(A), is_function(A) ->
                  is_function;
              t1(A) when is_integer(A), is_integer(A) ->
                  is_integer;
              t1(A) when is_list(A), is_list(A) ->
                  is_list;
              t1(A) when is_number(A), is_number(A) ->
                  is_number;
              t1(A) when is_pid(A), is_pid(A) ->
                  is_pid;
              t1(A) when is_port(A), is_port(A) ->
                  is_port;
              t1(A) when is_record(A, apa), is_record(A, apa) ->
                  is_record;
              t1(A) when is_record(A, apa, 1), is_record(A, apa, 1) ->
                  is_record;
              t1(A) when is_reference(A), is_reference(A) ->
                  is_reference;
              t1(A) when is_tuple(A), is_tuple(A) ->
                  is_tuple;
              t1(A) when list(A), list(A) ->
                  list;
              t1(A) when number(A), number(A) ->
                  number;
              t1(A) when pid(A), pid(A) ->
                  pid;
              t1(A) when port(A), port(A) ->
                  port;
              t1(A) when record(A, apa), record(A, apa) ->
                  record;
              t1(A) when reference(A), reference(A) ->
                  reference;
              t1(A) when tuple(A), tuple(A) ->
                  tuple.
           

