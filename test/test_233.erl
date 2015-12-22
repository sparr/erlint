-export([t/0]).
            -type range(A, B) :: A | B.

            -type union(A) :: A.

            -type product() :: integer().

            -type tuple(A) :: A.

            -type map(A) :: A.

            -type record() :: a | b.

            -type integer(A) :: A.

            -type atom(A) :: A.

            -type binary(A, B) :: A | B.

            -type 'fun'() :: integer().

            -type 'fun'(X) :: X.

            -type 'fun'(X, Y) :: X | Y.

            -type all() :: range(atom(), integer()) | union(pid()) | product()
                         | tuple(reference()) | map(function()) | record()
                         | integer(atom()) | atom(integer())
                         | binary(pid(), tuple()) | 'fun'(port())
                         | 'fun'() | 'fun'(<<>>, 'none').

            -spec t() -> all().

            t() ->
                a.
    

