-record(apa,{}).
              t2(A) when atom(A); atom(A) ->
                  atom;
              t2(A) when binary(A); binary(A) ->
                  binary;
              t2(A) when float(A); float(A) ->
                  float;
              t2(A) when function(A); function(A) ->
                  function;
              t2(A) when integer(A); integer(A) ->
                  integer;
              t2(A) when is_atom(A); is_atom(A) ->
                  is_atom;
              t2(A) when is_binary(A); is_binary(A) ->
                  is_binary;
              t2(A) when is_float(A); is_float(A) ->
                  is_float;
              t2(A) when is_function(A); is_function(A) ->
                  is_function;
              t2(A) when is_integer(A); is_integer(A) ->
                  is_integer;
              t2(A) when is_list(A); is_list(A) ->
                  is_list;
              t2(A) when is_number(A); is_number(A) ->
                  is_number;
              t2(A) when is_pid(A); is_pid(A) ->
                  is_pid;
              t2(A) when is_port(A); is_port(A) ->
                  is_port;
              t2(A) when is_record(A, apa); is_record(A, apa) ->
                  is_record;
              t2(A) when is_record(A, gurka, 1); is_record(A, gurka, 1) ->
                  is_record;
              t2(A) when is_reference(A); is_reference(A) ->
                  is_reference;
              t2(A) when is_tuple(A); is_tuple(A) ->
                  is_tuple;
              t2(A) when list(A); list(A) ->
                  list;
              t2(A) when number(A); number(A) ->
                  number;
              t2(A) when pid(A); pid(A) ->
                  pid;
              t2(A) when port(A); port(A) ->
                  port;
              t2(A) when record(A, apa); record(A, apa) ->
                  record;
              t2(A) when reference(A); reference(A) ->
                  reference;
              t2(A) when tuple(A); tuple(A) ->
                  tuple.
           

