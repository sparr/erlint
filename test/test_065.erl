-record(apa, {}).
              t3(A) when float(A) or float(A) -> % coercing... (badarg)
                  float;
              t3(A) when is_atom(A) or is_atom(A) ->
                  is_atom;
              t3(A) when is_binary(A) or is_binary(A) ->
                  is_binary;
              t3(A) when is_float(A) or is_float(A) ->
                  is_float;
              t3(A) when is_function(A) or is_function(A) ->
                  is_function;
              t3(A) when is_integer(A) or is_integer(A) ->
                  is_integer;
              t3(A) when is_list(A) or is_list(A) ->
                  is_list;
              t3(A) when is_number(A) or is_number(A) ->
                  is_number;
              t3(A) when is_pid(A) or is_pid(A) ->
                  is_pid;
              t3(A) when is_port(A) or is_port(A) ->
                  is_port;
              t3(A) when is_record(A, apa) or is_record(A, apa) ->
                  is_record;
              t3(A) when is_record(A, apa, 1) or is_record(A, apa, 1) ->
                  is_record;
              t3(A) when is_reference(A) or is_reference(A) ->
                  is_reference;
              t3(A) when is_tuple(A) or is_tuple(A) ->
                  is_tuple.
           

