
            -module(newly).

            -compile(export_all).

            %% No longer allowed in 17.0:
            -type arity() :: atom().
            -type bitstring() :: list().
            -type iodata() :: integer().
            -type boolean() :: iodata().

            -type t() :: arity() | bitstring() | iodata() | boolean().

            -spec t() -> t().

            t() ->
                1.
         

