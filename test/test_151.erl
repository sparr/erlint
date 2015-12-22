
            -module(newly).

            -compile(export_all).

            %% Built-in:
            -type node() :: node().
            -type mfa() :: tuple().
            -type gb_tree() :: mfa(). % Allowed since Erlang/OTP 17.0
            -type digraph() :: [_].   % Allowed since Erlang/OTP 17.0

            -type t() :: mfa() | digraph() | gb_tree() | node().

            -spec t() -> t().

            t() ->
                1.
         

