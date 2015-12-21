% test suite to generate many different warnings/errors
% naively extracted from erl_lint_SUITE.erl from the main OTP test suite

f(F) -> % F unused.
                ok.

            f(F, F) ->
                ok.

            g(_X) ->
                y.

            h(P) ->
                P.

            x(N) ->
                case a:b() of
                    [N|Y] -> % Y unused.
                        ok
                end.

            y(N, L) ->
                lists:map(fun(T) -> T*N end, L).

            z(N, L) -> % N unused
                lists:map(fun(N, T) -> T*N end, L).  % N shadowed.


            c(A) ->
                case A of
                    1 -> B = []; % B unused.
                    2 -> B = []; % B unused.
                    3 -> B = f, B
                end.
           
-record(r, {x,y}).
              f({X,Y}) -> {Z=X,Z=Y};
              f([H|T]) -> [Z=H|Z=T];
              f(#r{x=X,y=Y}) -> #r{x=A=X,y=A=Y}.
              g({M, F}) -> (Z=M):(Z=F)();
              g({M, F, Arg}) -> (Z=M):F(Z=Arg).
              h(X, Y) -> (Z=X) + (Z=Y).
bin([X]) ->
                  [A || <<A:X>> <- []]; % X used, not shadowed.
              bin({X}) ->
                  [X || <<X:X>> <- []]; % X used, and shadowed.
              bin({X,Y,Z}) ->
                  [{A,B} || <<A:X>> <- Z, <<B:Y>> <- Z];
              bin([X,Y,Z]) -> % Y unused.
                  [C || <<V:X>> <- Z, <<B:V>> <- Z, <<C:B>> <- Z].
           
bin([X]) ->
                  [A || <<A:X>> <- []]; % X used, not shadowed.
              bin({X}) ->
                  [X || <<X:X>> <- []]; % X used, and shadowed.
              bin({X,Y,Z}) ->
                  [{A,B} || <<A:X>> <- Z, <<B:Y>> <- Z];
              bin([X,Y,Z]) -> % Y unused.
                  [C || <<V:X>> <- Z, <<B:V>> <- Z, <<C:B>> <- Z].
           
a([A]) ->
                  B = foo,
                  [{C,B} || {C,_} <- A];
              a({A}) ->
                  B = foo,
                  [C || {C,_} <- [B,A]];
              a({A,A}) ->
                  B = foo,
                  [C || {C,_} <- B, B < A].
           
b(A) ->
                  B = foo, % B unused.
                  [C || {C,_} <- A].
           
c(A) ->
                  B = foo,
                  [C || {C,_} <- A],
                  B.
           
d(A) ->
                  B = foo,
                  [{A,B} || {Id,_} <- A]. % Id unused.
           
e(A) ->
                  B = foo, % B unused.
                  [B || B <- A]. % B shadowed.
           
f(A) ->
                  B = foo,
                  [B || B <- A], % B shadowed.
                  B.
           
g(A) ->
                  B = foo, % B unused.
                  [A || B <- A]. % B shadowed, B unused.
           
h(A) ->
                  B = foo,
                  [A || B <- A], % B shadowed, B unused.
                  B.
           
i(X) ->
                  [Z || Z <- X, % Z unused.
                        Z = X <- [foo]]. % X and Z shadowed. X unused!
           
j({X}) ->
                  [Z || Z <- X, % Z unused.
                        Z <- X = [[1,2,3]], % Z shadowed. Z unused.
                        Z <- X, % Z shadowed. Z unused.
                        Z <- X]; % Z shadowed.
              j(X) ->
                  [foo || X <- X, % X shadowed.
                        X <-    % X shadowed. X unused.
                             X = 
                                 Y = [[1,2,3]], % Y unused.
                        X <- [], % X shadowed.
                        X <- X]. % X shadowed. X unused.
           
k(X) ->
                  [Z || Z <- Y = X]; % Y unused.
              k(X) ->
                  [Z || Z <- X = Y = X]; % Y unused!
              k(X) ->
                  [Z || Z <- begin X = Y = X, Y end];
              k(X) ->
                  [{Y,W} || W <- Y = X]; % Y unbound
              k(X) ->
                  [Z || Z <- (Y = X), % Y unused.
                       Y > X]; % Y unbound.
              k(X) ->
                  [Y || Y = X > 3, Z = X]; % Z unused.
              k(X) ->
                  [Z || Y = X > 3, Z = X]. % Y unused.
           
lc2() ->
                  Z = [[1],[2],[3]], 
                  [X || Z <- Z, % Z shadowed.
                        X <- Z].
           
lc3() ->
                  Z = [1,2,3], 
                  [X || X <- Z, 
                        Z <- Z]. % Z shadowed. Z unused.
           
bin(Z) ->
                  case bar of
                      true ->
                          U = 2;
                      false ->
                          true
                  end,
                  case bar of
                      true ->
                          X = 2;
                      false ->
                          X = 3
                  end,
                  case foo of
                      true ->
                          Y = 3; % Y unused.
                      false ->
                          4
                  end,
                  case foo of
                      1 ->
                          U; % U unsafe.
                      2 ->
                          [Z || <<U:X>> <- Z]; % (X exported.) U unused.
                      3 ->
                          [Z || <<U:X>> <- Z], % (X exported.) U unused.
                          U % U unsafe.
                  end.
           
bin(Z) ->
                  %% This used to pass erl_lint...
                  case bar of
                      true ->
                          U = 2;
                      false ->
                          true
                  end,
                  case bar of
                      true ->
                          X = 2;
                      false ->
                          X = 3
                  end,
                  case foo of
                      true ->
                          Y = 3; % Y unused.
                      false ->
                          4
                  end,
                  [Z || <<U:X>> <- Z], % (X exported.) U unused.
                  U. % U unsafe.
           
bin(Z) ->
                  case bar of
                      true ->
                          U = 2;
                      false ->
                          true
                  end,
                  case bar of
                      true ->
                          X = 2;
                      false ->
                          X = 3
                  end,
                  case foo of
                      true ->
                          Y = 3;
                      false ->
                          4
                  end,
                  [B || <<U: % U unused
                          U>> <- X, <<B:Y>> <- Z]. % U unsafe. Y unsafe. 
                                                   % U shadowed. (X exported.)
           
p({B,C}) ->
                  <<A:B,A:C>> = <<17:32>>;
              p(B) ->
                  <<A:B>> = <<17:32>>. % A unused.
           
c({I1,I2}) ->
                  if
                      <<I1:I2>> == <<>> ->
                          foo
                  end;
              c([C1,C2]) -> % C1 unused.
                  case foo of
                      <<C2:C2,
                        C3:C2>> -> % C3 unused.
                          bar
                  end.

           
t() ->
                  S = 8,
                  case <<3:8>> of
                      <<X:S>> ->
                          X;
                      <<S:X>> -> % X unbound
                          foo
                  end;
              t() ->
                  S = 8,
                  case <<3:8>> of
                      <<S:S>> ->
                          S;
                      <<Q:32>> -> % Q unused.
                          foo
                  end.
           
-record(edge,
                      {ltpr,
                       ltsu,
                       rtpr,
                       rtsu
                      }).

              f1(#edge{ltpr = A, ltsu = A}) ->
                  true;
              f1({Q, Q}) ->
                  true.

              f2(Edge, Etab) ->
                  case gb_trees:lookup(Edge, Etab) of
                      {value,#edge{ltpr=Same,ltsu=Same}} -> ok;
                      {value,_} -> error
                  end.

              bar(Edge, Etab) ->
                  case gb_trees:lookup(Edge, Etab) of
                      {Same,Same} -> ok;
                      {value,#edge{ltpr=Same}} -> ok; % Same unused.
                      {value,_} -> error
                  end.
           
-record(r, {a,b}).
              f(X, Y) -> #r{a=[K || K <- Y], b=[K || K <- Y]}.
              g(X, Y) -> #r{a=lists:map(fun (K) -> K end, Y),
                            b=lists:map(fun (K) -> K end, Y)}.
              h(X, Y) -> #r{a=case Y of _ when is_list(Y) -> Y end,
                            b=case Y of _ when is_list(Y) -> Y end}.
              i(X, Y) -> #r{a=if is_list(Y) -> Y end, b=if is_list(Y) -> Y end}.
             
-record(r, {a}).
              t() -> X = 1, #r{a=foo, a=bar, a=qux}.
             
a({A,B}) -> % A unused.
                  fun(A) -> B end; % A shadowed. A unused.
              a([A,B]) ->
                  fun(<<A:B>>, % A shadowed. A unused.
                       <<Q:A>>) -> foo % Q unused.
                  end;
              a({A,B,C,D,E}) ->
                  fun(E) when C == <<A:A>>, <<17:B>> == D -> % E shadowed. E unused.
                          foo
                  end,
                  E;
              a([A,B,C,D,E]) -> % E unused.
                  fun() ->
                          (C == <<A:A>>) and (<<17:B>> == D)
                  end.
           
u() ->
                  case foo of
                      true ->
                          U = 2;
                      false ->
                          true
                  end,
                  fun(U) -> foo end, % U unused.
                  U; % U unsafe.
              u() ->
                  case foo of
                      true ->
                          U = 2;
                      false ->
                          U = 3
                  end,
                  fun(U) -> foo end, % U shadowed. U unused.
                  U;
              u() ->
                  case foo of
                      true ->
                          U = 2; % U unused.
                      false ->
                          U = 3 % U unused.
                  end,
                  fun(U) -> foo end. % U shadowed. U unused.
           
u() ->
                  fun U() -> foo end, % U unused.
                  U; % U unbound.
              u() ->
                  case foo of
                      true ->
                          U = 2;
                      false ->
                          true
                  end,
                  fun U() -> foo end, % U unused.
                  U; % U unsafe.
              u() ->
                  case foo of
                      true ->
                          U = 2;
                      false ->
                          U = 3
                  end,
                  fun U() -> foo end, % U shadowed. U unused.
                  U;
              u() ->
                  case foo of
                      true ->
                          U = 2; % U unused.
                      false ->
                          U = 3 % U unused.
                  end,
                  fun U() -> foo end; % U shadowed. U unused.
              u() ->
                  fun U(U) -> foo end; % U shadowed. U unused.
              u() ->
                  fun U(1) -> U; U(U) -> foo end; % U shadowed. U unused.
              u() ->
                  fun _(N) -> N + 1 end.  % Cover handling of '_' name.
           
objs(<<Size:4/unit:8, B:Size/binary>>) ->
                  B.

              fel(<<Size:4/unit:8, B:BadSize/binary>>) -> % BadSize unbound.
                  BadSize.                                % B, Size unused.

              r9c_highlight() -> % B, Rest unused.
                 <<Size, B:Size/binary,Rest/binary>> = <<2,"AB",3,"CDE">>.
t1() ->
                  UnusedVar1 = unused1,
                  try
                      UnusedVar2 = unused2
                  catch
                      _:_ ->
                          ok
                  end,
                  ok.
           
t2() ->
                  try
                      X = 1
                  catch
                      _:_ -> ok
                  end.
           
t3(X, Y) ->
                  X andalso Y.
           
t4() ->
                  _ = (catch X = X = 1),
                  _ = case ok of _ -> fun() -> ok end end,
                  fun (X) -> X end.
           
u() ->
                  case foo of
                      1 ->
                          A = 1,
                          B = 2,
                          W = 3, % W unused.
                          Z = 3; % Z unused.
                      2 ->
                          B = 2,
                          Z = 4 % Z unused.
                  end,
                  case bar of
                      true ->
                          A = 17, % A unsafe.
                          X = 3, % X unused.
                          U = 2,
                          U;
                      false ->
                          B = 19, % B exported.
                          U = 3; % U unused.
                      foo ->
                          X = 3,
                          X;
                      bar ->
                          X = 9, % X unused.
                          U = 14 % U unused.
                  end.
           
bin(A) ->
                  receive
                      M ->
                           X = M,
                           Y = M,
                           Z = M
                  end,
                  [B || <<B:X>> <- A], % X exported.
                  Y = B, % Y exported. B unbound.
                  [B || B <- Z]. % Z exported. B shadowed.
           
bin(A) ->
                  receive
                      M ->
                           X = M,
                           Y = M,
                           Z = M
                  end,
                  [B || <<B:X>> <- A], % (X exported.)
                  Y = B, % Y exported. B unbound.
                  [B || B <- Z]. % (Z exported.) B shadowed.
           
t(X) ->
                  if true -> Z = X end,
                  case X of
                      1 -> Z;
                      2 -> X
                  end,
                  Z = X.
           
bin(A) ->
                  receive
                      M ->
                           X = M,
                           Y = M,
                           Z = M
                  end,
                  [B || <<B:X>> <- A],
                  Y = B,
                  [B || B <- Z]. % B shadowed.
           
t() ->
                  _ = (catch MS = MS = 1), % MS used unsafe
                  _ = case ok of _ -> fun() -> ok end end,
                  fun (MS) -> MS end. % MS not shadowed here
           
-import(lists, [map/2,foldl/3]).
              t(L) ->
                 map(fun(X) -> 2*X end, L).
           
-export([t/1]).
              t(L) ->
                 lists:map(fun(X) -> 2*X end, L).

              fact(N) ->
                fact_1(N, 1).

              fact_1(1, P) -> P;
              fact_1(N, P) -> fact_1(N-1, P*N).
           
-export([t/1]).
              t(L) ->
                 lists:map(fun(X) -> 2*X end, L).

              b(X) ->
                32*X.
           
-export([t/1]).
              -compile(nowarn_unused_function).

              t(L) ->
                 lists:map(fun(X) -> 2*X end, L).

              b(X) ->
                32*X.
           
t() ->
                 (X = true) orelse (Y = false),
                  Y.
           
t2() ->
                  (X = true) orelse (Y = false),
                  X.
           
t3() ->
                  (X = true) andalso (Y = false),
                  Y.
           
t4() ->
                  (X = true) andalso (true = X),
                  X.
           
t5() ->
                  Y = 3,
                  (X = true) andalso (X = true),
                  {X,Y}.
           
t6() ->
                  X = true,
                  (X = true) andalso (true = X),
                  X.
           
t7() ->
                  (if true -> X = 3; false -> true end) 
                      andalso (X > 2),
                  X.
           
t8(X) ->
                  case X of _ -> catch _Y = 1 end,
                  _Y.
t9(X) ->
                  case X of
                      1 ->
                          catch A = 1, % unsafe only here
                          B = 1,
                          C = 1,
                          D = 1;
                      2 ->
                          A = 2,
                          % B not bound here
                          C = 2,
                          catch D = 2; % unsafe in two clauses
                      3 ->
                          A = 3,
                          B = 3,
                          C = 3,
                          catch D = 3; % unsafe in two clauses
                      4 ->
                          A = 4,
                          B = 4,
                          C = 4,
                          D = 4
                  end,
                  {A,B,C,D}.
foo(State) ->
                  case State of
                      true ->
                          if
                              false -> ok;
                              true ->  State1=State
                          end
                  end,
                  State1. % unsafe
           
foo(State) ->
                  case State of
                      true ->
                          if
                              false -> ok;
                              true ->  State1=State
                          end
                  end,
                  State1. % unsafe
           
foo2() ->
                try self()
                catch
                  Class:Data -> Result={Class,Data}
                end,
                Result.
              foo3a() ->
                try self() of
                  R -> R
                catch
                  Class:Data -> Result={Class,Data}
                end,
                Result.
              foo3b() ->
                try self() of
                  Result -> ok
                catch
                  Class:Data -> {Class,Data}
                end,
                Result.
           
foo1a() ->
                Try = 
                  try self()
                  catch
                    Class:Data -> Rc={Class,Data}
                  after
                    Ra=ok
                  end,
                {Try,Rc,Ra}.
              foo1b() ->
                Try = 
                  try self() of
                    R -> R
                  catch
                    Class:Data -> Rc={Class,Data}
                  after
                    Ra=R
                  end,
                {Try,Rc,Ra}.
              foo2() ->
                Try = 
                  try self() of
                    R -> Ro=R
                  catch
                    Class:Data -> {Class,Data}
                  after
                    Ra=R
                  end,
                {Try,Ro,Ra}.
              foo3() ->
                Try = 
                  try self() of
                    R -> Ro=R
                  catch
                    Class:Data -> Rc={Class,Data}
                  after
                    Ra=R
                  end,
                {Try,R,Ro,Rc,Ra}.
           
foo1(X) ->
                Try = 
                  try R=self()
                  catch
                    Class:Data -> Rc={X,R,Class,Data}
                  end,
                {X,Try,Rc}.
          foo2(X) ->
                Try = 
                  try R=self() of
                    RR -> Ro={X,R,RR}
                  catch
                    Class:Data -> {X,R,RR,Ro,Class,Data}
                  end,
                {X,Try,R,RR,Ro,Class,Data}.
          foo3(X) ->
                Try = 
                  try R=self() of
                    RR -> {X,R,RR}
                  catch
                    Class:Data -> {X,R,RR,Class,Data}
                  after
                    Ra={X,R,RR,Class,Data}
                  end,
                {X,Try,R,RR,Ra,Class,Data}.
           
foo1(X) ->
                Try = 
                  try R=self() of
                    RR -> Ro={X,R,RR}
                  catch
                    Class:Data -> Rc={X,R,RR,Ro,Class,Data}
                  after
                    Ra={X,R,RR,Ro,Rc,Class,Data}
                  end,
                {X,Try,R,RR,Ro,Rc,Ra,Class,Data}.
           
bang() ->
                case 1 of
                  nil ->
                    Acc = 2;
                  _ ->
                    try
                      Acc = 3,
                      Acc
                    catch _:_ ->
                      ok
                    end
                end,
                Acc.
           
t({bc,binary,Bin}) ->
          << <<X,Tail/binary>> || <<X,Tail/binary>> <= Bin >>;
          t({bc,bits,Bin}) ->
          << <<X,Tail/bits>> || <<X,Tail/bits>> <= Bin >>;
          t({bc,bitstring,Bin}) ->
          << <<X,Tail/bits>> || <<X,Tail/bitstring>> <= Bin >>;
          t({lc,binary,Bin}) ->
          [ {X,Tail} || <<X,Tail/binary>> <= Bin ];
          t({lc,bits,Bin}) ->
          [ {X,Tail} || <<X,Tail/bits>> <= Bin ];
          t({lc,bitstring,Bin}) ->
          [ {X,Tail} || <<X,Tail/bitstring>> <= Bin ].
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
           
-record(apa, {}).
               t3(A) when record(A, {apa}) ->
                   foo;
               t3(A) when is_record(A, {apa}) ->
                   foo;
               t3(A) when erlang:is_record(A, {apa}) ->
                   foo;
               t3(A) when is_record(A, {apa}, 1) ->
                   foo;
               t3(A) when erlang:is_record(A, {apa}, 1) ->
                   foo;
               t3(A) when is_record(A, apa, []) ->
                   foo;
               t3(A) when erlang:is_record(A, apa, []) ->
                   foo;
               t3(A) when record(A, apa) ->
                   foo;
               t3(A) when is_record(A, apa) ->
                   foo;
               t3(A) when erlang:is_record(A, apa) ->
                   foo.
            
-record(apa,{a=a,b=foo:bar()}).
              apa() ->
                 [X || X <- [], #apa{a = a} == {r,X,foo}];
              apa() ->
                 [X || X <- [], #apa{b = b} == {r,X,foo}];
              apa() ->
                 [X || X <- [], #ful{a = a} == {r,X,foo}].
            
-record(apa,{}).
               t() ->
               [X || X <- [1,#apa{},3], (3+is_record(X, apa)) or 
                                        (is_record(X, apa)*2)].
            
t(A) when erlang:is_foobar(A) -> ok;
          t(A) when A ! ok -> ok;
          t(A) when A ++ [x] -> ok.
t(X, Y) when erlang:'andalso'(X, Y) -> ok;
               t(X, Y) when erlang:'orelse'(X, Y) -> ok.
            
t() ->
                  X = {foo},
                  is_record(X, foo),
                  erlang:is_record(X, foo),
                  {erlang,is_record}(X, foo),
                  %% Note: is_record/3 does not verify that the record is defined,
                  %% so the following lines should give no errors.
                  is_record(X, foo, 1),
                  erlang:is_record(X, foo, 1),
                  {erlang,is_record}(X, foo, 1).
             
-compile({inline, [{f,3},{f,4},{f,2},{f,a},{1,foo}]}).
              -compile({inline, {g,1}}).
              -compile({inline, {g,12}}).
              -compile(inline).
              -compile({inline_size,100}).

              f(A, B) ->
                  {g(A), B}.

              g(A) ->
                  {A}.
             
t() ->
                 [{Type, Value} || <<Type:16, _Len:16, 
                                    Value:_Len/binary>> <- []].
             
t() ->
                 %% This one has always been handled OK:
                 <<Type:16, _Len:16, 
                      Value:_Len/binary>> = <<18:16, 9:16, "123456789">>.
t() ->
                 fun(<<Type:16, _Len:16, Value:_Len/binary>>) ->
                     {Type, Value}
                 end.
             
t() ->
                 L = 8,
                 F = fun(<<A:L,B:A>>) -> B end,
                 F(<<16:8, 7:16>>).
             
t() ->
                 L = 8,
                 F = fun(<<L: % L shadowed.
                            L,
                           B:
                            L>>) -> B end,
                 F(<<16:8, 7:16>>).
             
t(A) ->
                 (fun(<<L:16,M:L,N:M>>) -> ok end)(A).
             
t() ->
                  U = 8, 
                  (fun(<<U: % U shadowed.
                          U>>) -> U end)(<<32:8>>).
             
t() ->
                  [X || <<A:8,
                          B:A>> <- [],
                        <<X:8>> <- [B]].
             
t() ->
                  L = 8,
                  F = fun(<<L: % Shadow.
                           L,
                           L:
                           L,
                           L:
                           L
                           >>) ->
                              L
                      end,
                  F(<<16:8, 8:16, 32:8>>).
             
t() ->
                L = 8, <<A:L,B:A>> = <<16:8, 7:16>>, B.
             
t() ->
                fun(<<L:16,L:L,L:L>>) -> ok end.
             
t([A,B]) ->
                 fun(<<A:B>>, % A shadowed and unused
                     <<Q:A>>) -> foo % Q unused. 'outer' A is used.
                 end.
             
t([A,B]) -> % A unused, B unused
                 fun({A,B}, % A shadowed, B unused, B shadowed
                     {Q,A}) -> foo % Q unused. 'inner' A is used
                 end.
             
t() ->
                 A = 4,
                 fun(<<A: % shadowed, unused
                       A>>) -> 2 end.
             
t() ->
                 A = 4, % unused
                 fun(<<A:8, % shadowed
                       16:A>>) -> 2 end.
             
t() ->
                 A = 4,
                 fun(<<8:A, % 
                       A:8>>) -> 7 end. % shadowed, unused
             
t() ->
                 L = 16,
                 fun(<<L: % shadow
                       L>>, % 'outer' L
                     <<L: % shadow and match
                       L>>) -> % 'outer' L
                         a
                 end.
             
t() ->
                 L = 4,      % L unused
                 fun({L,     % L shadowed
                      L},
                     {L,
                      L}) ->
                         a
                 end.
             
t() ->
                 L = 4,
                 [L || <<L: % shadowed
                         L, 
                         L:
                         L>> <- []].
             
t() ->
                 L = 4, % L unused.
                 [1 || L <- []]. % L unused, L shadowed.
             
t() ->
                 L = 4,
                 [1 || L <- [L]]. % L shadowed. L unused.
             
t() ->
                 L = 4, % unused
                 fun(L) -> L end. % shadowed
             
t([A,A]) -> a.
t({A,A}) -> a.
-record(r, {f1,f2}).
              t(#r{f1 = A, f2 = A}) -> a.
-deprecated([{frutt,0,next_version}]).
%             -deprecated([{does_not_exist,1}]).
             -deprecated('foo bar').
             -deprecated(module).
             -deprecated([{f,'_'}]).
             -deprecated([{t,0}]).
             -deprecated([{t,'_',eventually}]).
             -deprecated([{'_','_',never}]).
             -deprecated([{{badly,formed},1}]).
             -deprecated([{'_','_',next_major_release}]).
 %            -deprecated([{atom_to_list,1}]).
             -export([t/0]).
             frutt() -> ok.
             t() -> ok.
            
-compile(export_all).

             -deprecated({t,0}).

             t() ->
                 foo.
            
-compile(export_all).

             -record(r, {}).

             f(A) when list(A) -> list;
             f(R) when record(R, r) -> rec;
             f(P) when pid(P) -> pid.

             t() ->
                 f([]).
            
-record(c, {a = <<X:7/binary-unit:8>>}).
              t() ->
                  X = <<"hejsans">>.
-include_lib("stdlib/include/qlc.hrl").

             -file(?FILE, 1000).

             t() ->
                 qlc:q([X || X <- [],
                             begin A = 3, true end]).
            
-export([inline/0]).

             -import(lists, [a/1,b/1]). % b/1 is not used

             -compile([{inline,{inl,7}}]).    % undefined
             -compile([{inline,[{inl,17}]}]). % undefined
             -compile([{inline,{inl,1}}]).    % OK

             foop() ->   % unused function
                 a([]),  % used import, OK
                 fipp(). % undefined

             inline() ->
                 inl(foo).

             inl(_) ->
                 true.

             not_used() ->      % unused function
                 true.

             -compile({nowarn_unused_function,[{and_not_used,2}]}). % unknown 
             and_not_used(_) -> % unused function
                 foo.

             -compile({nowarn_unused_function,{unused_function,2}}).
             unused_function(_, _) ->
                 ok.
           
-record(a, {x,
                          x}).
              -record(a, {x,
                          X}). % erl_parse
              -record(a, [x,
                          x]). % erl_parse
              -record(ok, {a,b}).

              -record(r, {a = #ok{}, 
                          b = (#ok{})#ok.a}).

              t() ->
                  {#a{},
                   #nix{},
                   #ok{nix = []},
                   #ok{Var = 4}, 
                   #r{}
                  }.
           
-compile(nowarn_deprecated_function).
              -compile(nowarn_bif_clash).
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           
-compile(nowarn_deprecated_function).
              -compile(nowarn_bif_clash).
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           
-compile({nowarn_deprecated_function,{erlang,hash,2}}).
              -compile({nowarn_bif_clash,{spawn,1}}).
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           
-export([spawn/1]).
              -compile({nowarn_deprecated_function,{erlang,hash,2}}).
              -compile({nowarn_bif_clash,{spawn,1}}).
              -compile({nowarn_bif_clash,{spawn,2}}). % bad
              -compile([{nowarn_deprecated_function, 
                                [{erlang,hash,-1},{3,hash,-1}]}, % 2 bad
                     {nowarn_deprecated_function, {{a,b,c},hash,-1}}]). % bad
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           
-export([spawn/1]).
              -compile(warn_deprecated_function).
              -compile(warn_bif_clash).
              spawn(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           
-include_lib("stdlib/include/qlc.hrl").
              -record(a, {x = qlc:q([{X,Y} || {X} <- [],{Y} <- [],X =:= Y])}).
              -export([t/0]).              
              t() -> #a{}.
          
-compile({nowarn_deprecated_function,{erlang,hash,2}}).
              -compile({nowarn_bif_clash,{spawn,1}}).
              -import(x,[spawn/1]).
              spin(A) ->
                  erlang:hash(A, 3000),
                  spawn(A).
           
t(X) -> erlang:hash(X, 2000).
t(X) -> regexp:match(X).
t(<<A:8>> = <<B:8>>) ->
                  {A,B}.
             
x([<<A:8>>] = [<<B:8>>]) ->
                  {A,B}.
              y({a,<<A:8>>} = {b,<<B:8>>}) ->
                  {A,B}.
             
-record(foo, {a,b,c}).
              -record(bar, {x,y,z}).
              -record(buzz, {x,y}).
              a(#foo{a = <<X:8>>} = #bar{x = <<Y:8>>}) ->
                  {X,Y}.
              b(#foo{b = <<X:8>>} = #foo{b = <<Y:4,Z:4>>}) ->
                  {X,Y,Z}.
              c(#foo{a = <<X:8>>} = #buzz{x = <<Y:8>>}) ->
                  {X,Y}.
              d(#foo{a=x,b = <<X:8>>} = #buzz{y = <<Y:8>>}) ->
                  {X,Y}.
              e(#foo{a=x,b = <<X:8>>} = #buzz{x=glurf,y = <<Y:8>>}) ->
                  {X,Y}.
             
-record(foo, {a,b,c}).
              -record(bar, {x,y,z}).
              -record(buzz, {x,y}).
              a(#foo{a = <<X:8>>,b=x} = #foo{b = <<Y:8>>}) ->
                  {X,Y}.
              b(#foo{a = <<X:8>>} = #bar{y = <<Y:4,Z:4>>}) ->
                  {X,Y,Z}.
              c(#foo{a = <<X:8>>} = #buzz{y = <<Y:8>>}) ->
                  {X,Y}.
             
t([<<A:8>> = {C,D} = <<B:8>>]) ->
                  {A,B,C,D}.
             
t([(<<A:8>> = {C,D}) = <<B:8>>]) ->
                  {A,B,C,D}.
             
t([(<<A:8>> = {C,D}) = (<<B:8>> = <<C:8>>)]) ->
                  {A,B,C,D}.
             
t(Val) ->
                  <<A:8>> = <<B:8>> = Val,
                  {A,B}.
             
t(Val) ->
                  <<A:8>> = X = <<B:8>> = Val,
                  {A,B,X}.
             
t(X, Y) ->
                  <<A:8>> = <<X:4,Y:4>>,
                  A.
             
t(Val) ->
                  (<<A:8>> = X) = (<<B:8>> = <<A:4,B:4>>) = Val,
                  {A,B,X}.
             
t(Val) ->
                  (<<A:8>> = X) = (Y = <<B:8>>) = Val,
                  {A,B,X,Y}.
             
t(Val) ->
                  (Z = <<A:8>> = X) = (Y = <<B:8>> = W) = Val,
                  {A,B,X,Y,Z,W}.
             
-export([t/0]).
              -export([t/0]).
              t() -> a.
             
-record(c, {a = fun ?MODULE:i/1(17)}).
              t() ->
                  #c{}.

              i(X) ->
                  X.
            
-record(rec1, {a = #rec2{}}).
             -record(rec2, {a = #rec1{}}).
             t() ->#rec1{}.
            
-record(r1, {a = begin A = 4, {A,B} end}). % B unbound
              -record(r2, {e = begin A = 3, #r1{} end}).
              t() -> #r2{}.
             
-record(r1, {t = case foo of _ -> 3 end}).
              -record(r2, {a = case foo of A -> A; _ -> 3 end}).
              -record(r3, {a = case foo of A -> A end}).
              -record(r4, {a = fun _AllowedFunName() -> allowed end}).
              t() -> {#r1{},#r2{},#r3{},#r4{}}.
             
-record(r1, {foo = A}). % A unbound
              -record(r2, {a = fun(X) -> X end(3)}).
              -record(r3, {a = [X || X <- [1,2,3]]}).
              t() -> {#r1{},#r2{},#r3{}}.
             
-record(r1, {a = {A, % A unbound
                                A}}). % A unbound
              -record(r2, {a = begin case foo of 
                                         A -> A
                                     end,
                                     A
                                end}).
              -record(r3, {a = fun(X) ->
                                       case foo of
                                           A -> A
                                       end
                               end
                          }).
              -record(r4, {a = case foo of
                                   foo ->
                                       case foo of
                                           A -> A
                                       end;
                                   _ -> 
                                       bar
                               end}).
              t() -> {#r1{},#r2{},#r3{},#r4{}}.
             
-record(r1, {a = fun(NotShadowing) -> NotShadowing end}).
              t() ->
                  NotShadowing = 17,
                  {#r1{}, NotShadowing}.
             
-record(r1, {a = fun(<<X:8>>) -> X end,
                           b = case <<17:8>> of
                                   <<_:Y>> -> Y;
                                   <<Y:8>> -> 
                                       Y
                               end}).
              t() -> #r1{}.
             
-record(r, {a = [X || {A,Y} <- [{1,2},V={3,4}],
                                    begin Z = [1,2,3], true end,
                                    X <- Z ++ [A,Y]]}).
              t() ->#r{}.
             
-record(r, {a = foo()}). % unused

              t() -> ok.
             
-module(lint_test, [A, B]).
            
-module(lint_test).
              -include_lib("stdlib/include/qlc.hrl").
              -export([t/0]).
              -record(r1, {a = qlc:e(qlc:q([X || X <- [1,2,3]]))}).
              -record(r2, {a = qlc:q([X || X <- [1,2,3]])}).
              -record(r3, {a = qlc:q([X || {A,Y} <- [{1,2},V={3,4}],
                                           begin Z = [1,2,3], true end,
                                           X <- Z ++ [A,Y]])}).
              t() -> {#r1{},#r2{},#r3{}}.
             
-module(lint_test).
              -export([t/0]).
              -record(r, {a = true}).
              -record(r1, {a,b}).
              -record(r2, {a = #r1{a = true}}).
              -record(r3, {a = A}). % A is unbound
              -record(r4, {a = dict:new()}).

              t() ->
                  case x() of
                      _ when (#r{})#r.a ->
                          a; 
                      _ when (#r4{})#r.a -> % illegal
                          b;
                      _ when (#r3{q = 5})#r.a -> % no warning for unbound A
                          q;
                      _ when (#r{q = 5})#r.a ->
                          a; 
                      _ when (((#r{a = #r2{}})#r.a)#r2.a)#r1.a ->
                          b;
                      _ when #r{a = dict:new()} -> % illegal
                          c; 
                      _ when l() > 3 -> % illegal, does not use l/0...
                          d;
                      _ ->
                          w
                  end.

              l() ->
                  foo.

              x() ->
                  bar.
              
-module(lint_test).
              -export([t/0]).
              t() ->
                  case x() of
                      _ when l() 
                             or
                             l() ->
                          foo
                  end.
             
t() -> ok.
-module(lint_test).
                -export([t/0]).
                -record(u1, {a}).
                -record(u2, {a = #u1{}}).
                -record(u3, {a}). % unused
                -record(u4, {a = #u3{}}). % unused

                t() ->
                    {#u2{}}.
               
-module(lint_test).
                -export([t/0]).
                -record(u1, {a}).
                -record(u2, {a = #u1{}}).
                -file("some_file.hrl", 1).
                -record(u3, {a}). % unused, but on other file
                -record(u4, {a = #u3{}}). % -\"-

                t() ->
                    {#u2{}}.
               
-module(lint_test).
              -import(qlc, [q/2]).
              -export([t/0]).

              t() ->
                  H1 = qlc:q([X || X <- [1,2]]),
                  H2 = qlc:q([X || X <- [1,2]], []),
                  H3 = q([X || X <- [1,2]], []),
                  {H1,H2,H3}.
             
-module(t).
                    -export([foo/1]).
                    -record(sipurl,  {host :: string()}).
                    -record(keylist, {list = [] :: [_]}).
                    -type sip_headers() :: #keylist{}.
                    -record(request, {uri :: #sipurl{}, header :: sip_headers()}).

                    foo(#request{}) -> ok.
                  
-module(otp_6885).
            -export([t/1]).
            t(<<_/binary,I>>) -> I;
            t(<<X/binary,I:X>>) -> I;
        t(<<B/binary,T/binary>>) -> {B,T}.

            build(A, B) ->
               <<A/binary,B/binary>>.

            foo(<<"abc"/binary>>) ->
               ok;
            foo(<<"abc":13/integer>>) ->
               ok;
            foo(<<"abc"/float>>) ->
               ok;
            foo(<<"abc":19>>) ->
               ok;
            foo(<<"abc"/utf8>>) ->
               ok;
            foo(<<"abc"/utf16>>) ->
               ok;
            foo(<<"abc"/utf32>>) ->
               ok.

           
-module(otp_10436).
            -export_type([t1/0]).
            -opaque t1() :: {i, integer()}.
            -opaque t2() :: {a, atom()}.
         
-module(otp_10436_2).
             -export_type([t1/0, t2/0]).
             -opaque t1() :: term().
             -opaque t2() :: any().
         
-module(p2).
            -export([manifest/2]).
            manifest(Module, Name) ->
              fun Module:Nine/1.
         

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
         

            -module(map).

            -compile(export_all).

            -export_type([map/0, product/0]).

            -opaque map() :: dict().

            -spec t() -> map().

            t() ->
                1.
         
-module(export_all_module).
            -compile([export_all]).

            id(I) -> I.
           
t(X) ->
                  size(X).

              %% No warning for the following calls, since they
              %% are unambigous.
              b(X) ->
                  erlang:size(X).

              c(X) ->
                  ?MODULE:size(X).

              size({N,_}) ->
                N.
             
-export([t/1,size/1]).
              t(X) ->
                  size(X).

              size({N,_}) ->
                N.

              %% My own abs/1 function works on lists too. From R14 this really works.
              abs([H|T]) when $a =< H, H =< $z -> [H-($a-$A)|abs(T)];
              abs([H|T]) -> [H|abs(T)];
              abs([]) -> [];
              abs(X) -> erlang:abs(X).
             
-export([size/1]).
              size({N,_}) ->
                N;
              size(X) ->
                erlang:size(X).
             
-export([size/1]).
              size({N,_}) ->
                N;
              size(X) ->
                size(X).
             
-export([binary_part/2]).
              binary_part({B,_},{X,Y}) ->
                binary_part(B,{X,Y});
              binary_part(B,{X,Y}) ->
                binary:part(B,X,Y).
             
-export([size/1]).
              -compile({no_auto_import,[size/1]}).
              size([]) ->
                0;
              size({N,_}) ->
                N;
              size([_|T]) ->
                1+size(T).
             
-export([binary_part/2]).
              -compile({no_auto_import,[binary_part/2]}).
              binary_part({B,_},{X,Y}) ->
                binary_part(B,{X,Y});
              binary_part(B,{X,Y}) ->
                binary:part(B,X,Y).
             
-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              x(X) when binary_part(X,{1,2}) =:= <<1,2>> ->
                 hej.
              binary_part({B,_},{X,Y}) ->
                binary_part(B,{X,Y});
              binary_part(B,{X,Y}) ->
                binary:part(B,X,Y).
             
-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              x(X) ->
                 binary_part(X,{1,2}) =:= <<1,2>>.
             
-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              -import(erlang,[binary_part/2]).
              x(X) ->
                 binary_part(X,{1,2}) =:= <<1,2>>.
             
-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              -import(erlang,[binary_part/2]).
              x(X) when binary_part(X,{0,1}) =:= <<0>> ->
                 binary_part(X,{1,2}) =:= <<1,2>>.
             
-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              -import(erlang,[binary_part/2]).
              x(X) when binary_part(X,{0,1}) =:= <<0>> ->
                 binary_part(X,{1,2}) =:= fun binary_part/2.
             
-export([x/1]).
              -compile({no_auto_import,[binary_part/2]}).
              -import(x,[binary_part/2]).
              x(X) ->
                 binary_part(X,{1,2}) =:= fun binary_part/2.
             
-export([x/1]).
              x(X) when binary_part(X,{0,1}) =:= <<0>> ->
                 binary_part(X,{1,2}) =:= fun binary_part/2.
             
-export([x/1]).
              -import(x,[abs/1]).
              x(X) ->
                 binary_part(X,{1,2}).
             
-export([x/1]).
              -import(x,[binary_part/3]).
              x(X) ->
                 abs(X).
             
-export([x/1]).
              -import(x,[binary_port/3]).
              -import(y,[binary_port/3]).
              x(X) ->
                 abs(X).
             
-export([x/1]).
              -import(x,[binary_port/3]).
              binary_port(A,B,C) ->
                 binary_part(A,B,C).
              x(X) ->
                 abs(X).
             
-export([binary_port/3]).
              -compile({no_auto_import,[binary_part/3]}).
              -import(x,[binary_part/3]).
              binary_port(A,B,C) when x:binary_part(A,B,C) ->
                 binary_part(A,B,C+1).
             
-export([binary_port/3]).
              -import(x,[binary_part/3]).
              binary_port(A,B,C) ->
                 binary_part(A,B,C).
             
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
             
-export([size/1, binary_part/2]).
             -compile(no_auto_import).
             size([]) ->
               0;
             size({N,_}) ->
               N;
             size([_|T]) ->
               1+size(T).
             binary_part({B,_},{X,Y}) ->
               binary_part(B,{X,Y});
             binary_part(B,{X,Y}) ->
               binary:part(B,X,Y).
            
-behaviour(application).
             
-behaviour(application).
              -export([stop/1]).
              stop(_) -> ok.
             
-behavior(application).  %% Test American spelling.
              -export([start/2,stop/1]).
              start(_, _) -> ok.
              stop(_) -> ok.
             
-behavior(application).  %% Test callbacks with export_all
              -compile(export_all).
              stop(_) -> ok.
             
-behaviour(application).
              -behaviour(supervisor).
             
-behaviour(application).
              -behaviour(supervisor).
              -export([start/2,stop/1,init/1]).
              start(_, _) -> ok.
              stop(_) -> ok.
              init(_) -> ok.
             
-behavior(application).
              -behavior(supervisor).
              -export([start/2,stop/1,init/1]).
              start(_, _) -> ok.
              stop(_) -> ok.
              init(_) -> ok.
             
-behaviour(gen_server).
              -behaviour(supervisor).
              -export([handle_call/3,handle_cast/2,handle_info/2]).
              handle_call(_, _, _) -> ok.
              handle_cast(_, _) -> ok.
              handle_info(_, _) -> ok.
             
-behavior(gen_server).
              -behavior(supervisor).
              -export([handle_call/3,handle_cast/2,handle_info/2]).
              handle_call(_, _, _) -> ok.
              handle_cast(_, _) -> ok.
              handle_info(_, _) -> ok.
             
-behaviour(gen_server).
              -behaviour(gen_fsm).
              -behaviour(supervisor).
              -export([init/1,handle_call/3,handle_cast/2,
                       handle_info/2,handle_info/3,
                       handle_event/3,handle_sync_event/4,
                       code_change/3,code_change/4,
                       terminate/2,terminate/3,terminate/4]).
              init(_) -> ok.
              handle_call(_, _, _) -> ok.
              handle_event(_, _, _) -> ok.
              handle_sync_event(_, _, _, _) -> ok.
              handle_cast(_, _) -> ok.
              handle_info(_, _) -> ok.
              handle_info(_, _, _) -> ok.
              code_change(_, _, _) -> ok.
              code_change(_, _, _, _) -> ok.
              terminate(_, _) -> ok.
              terminate(_, _, _) -> ok.
              terminate(_, _, _, _) -> ok.
             

              -export([b1/1]).
              -behaviour(callback1).
              -behaviour(callback2).

              -spec b1(atom()) -> integer().
              b1(A) when is_atom(A)->
                  3.
             

              -export([b2/1]).
              -behaviour(callback1).
              -behaviour(callback2).

              -spec b2(integer()) -> atom().
              b2(I) when is_integer(I)->
                  a.
             

              -callback b(_) -> atom().
              -optional_callbacks({b1,1}). % non-existing and ignored
             

              -callback b(_) -> atom().
              -optional_callbacks([{b1,1}]). % non-existing
             

              -optional_callbacks([{b1,1}]). % non-existing
             

              -optional_callbacks([b1/1]). % non-existing
              behaviour_info(callbacks) -> [{b1,1}].
             

              -optional_callbacks([b1/1]). % non-existing
              -callback b(_) -> atom().
              behaviour_info(callbacks) -> [{b1,1}].
             

              -callback b(_) -> atom().
              -optional_callbacks([b/1, {b, 1}]).
             

              -behaviour(gen_server).
              -export([handle_call/3,handle_cast/2,handle_info/2,
                       code_change/3, init/1, terminate/2]).
              handle_call(_, _, _) -> ok.
              handle_cast(_, _) -> ok.
              handle_info(_, _) -> ok.
              code_change(_, _, _) -> ok.
              init(_) -> ok.
              terminate(_, _) -> ok.
             

              -behaviour(gen_server).
              -export([handle_call/3,handle_cast/2,handle_info/2,
                       code_change/3, init/1, terminate/2, format_status/2]).
              handle_call(_, _, _) -> ok.
              handle_cast(_, _) -> ok.
              handle_info(_, _) -> ok.
              code_change(_, _, _) -> ok.
              init(_) -> ok.
              terminate(_, _) -> ok.
              format_status(_, _) -> ok. % optional callback
             

              -optional_callbacks([{b1,1,bad}]). % badly formed and ignored
              behaviour_info(callbacks) -> [{b1,1}].
             

              -behaviour(bad_behaviour1).
             

              -behaviour(non_existing_behaviour).
             

              -behaviour(bad_behaviour_none).
             

              -callback b(_) -> atom().
             

              -optional_callbacks([{b1,1,bad}]). % badly formed
              -callback b(_) -> atom().
             

              -callback b(_) -> atom().
              -callback b(_) -> atom().
             

              -behaviour(bad_behaviour2).
             

              -export([f1/1]).
              -behaviour(callback3).
              f1(_) -> ok.
             
f8(A) ->
                  <<A:8/utf8>>.
              g8(A) ->
                  <<A:8/utf8-unit:1>>.
              h8(A) ->
                  <<A/utf8-unit:1>>.

              f16(A) ->
                  <<A:8/utf16>>.
              g16(A) ->
                  <<A:8/utf16-unit:1>>.
              h16(A) ->
                  <<A/utf16-unit:1>>.

              f32(A) ->
                  <<A:8/utf32>>.
              g32(A) ->
                  <<A:8/utf32-unit:1>>.
              h32(A) ->
                  <<A/utf32-unit:1>>.
             
-opaque foo() :: bar().
              -export_type([foo/0]).
             
-export([do_on_load/0]).
             -on_load(do_on_load/0).
             do_on_load() -> ok.
             
-on_load(do_on_load/0).
             do_on_load() -> ok.
             
-on_load(do_on_load/0).
             do_on_load() -> foo().
             foo() -> bar(5) + 42.
             bar(N) -> 2*N.
             
-on_load(atom).
             
-on_load({42,0}).
             
-on_load(foo/0).
              -on_load(bar/0).
              foo() -> ok.
              bar() -> ok.
             
-on_load(foo/1).
              foo(_) -> ok.
             
-on_load(non_existing/0).
             
f(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_) -> ok.
-module(redefine_module).
f() -> ok.
               -attr(x).
f() -> ok.
              f() -> ok.
-record(r, {a}).
              -record(r, {a}).
          f(#r{}) -> ok.
f1() -> record_info(42, record).
          f2() -> record_info(shoe_size, record).
f() -> a:b.
f(A+B) -> ok.
t(<<X:bad_size>>) -> X;
          t(<<_:(x ! y)/integer>>) -> ok;
              t(<<X:all/integer>>) -> X;
              t(<<X/bad_type>>) -> X;
          t(<<X/unit:8>>) -> X;
          t(<<X:7/float>>) -> X;
          t(<< <<_:8>> >>) -> ok;
          t(<<(x ! y):8/integer>>) -> ok;
              t(X) ->
                {<<X/binary-integer>>,<<X/signed-unsigned-integer>>,
                 <<X/little-big>>,<<X/unit:4-unit:8>>}.
        
t() ->
                  #{ a := b,
                     c => d,
                     e := f
                  }#{ a := b,
                      c => d,
                      e := f };
              t() when is_map(#{ a := b,
                                 c => d
                              }#{ a := b,
                                  c => d,
                                  e := f }) ->
                  ok.
            
t(#{ a := A,
                   c => d,
                   e := F,
                   g := 1 + 1,
                   h := _,
                   i := (_X = _Y),
                   j := (x ! y),
           <<0:300>> := 33}) ->
                  {A,F}.
            
t() -> #{ a := X }.
t(V) -> #{ a => 1,
            #{a=>V} => 2,
            #{{a,V}=>V} => 2,
            #{ "hi" => wazzup, hi => ho } => yep,
            [try a catch _:_ -> b end] => nope,
            ok => 1.0,
            [3+3] => nope,
            1.0 => yep,
            {3.0+3} => nope,
            {yep} => yep,
            [case a of a -> a end] => nope
              }.
       
t(#{ a := 2,
               #{} := A,
               #{ 3 => 33 } := hi,
               #{ 3 := 33 } := hi,
               #{ hi => 54, "hello" => 45 } := hi,
           #{ V => 33 } := hi }) ->
           A.
       
t(Foo, Bar, Baz) -> {#{},#{}}.

    -type m() :: #{a => integer()}.
    -spec t1(#{k=>term()}) -> {term(), map()}.

    t1(#{k:=V}=M) -> {V,M}.

    -spec t2(m()) -> integer().

    t2(#{a:=V}) -> V.
    

            %% Built-in var arity map type:
        -type map() :: tuple().
        -type a() :: map().

        -spec t(a()) -> a().
        t(M) -> M.
     
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
    
-export([a/1, b/1, t/0]).

            -callback b(_) -> integer().

            -callback ?MODULE:a(_) -> integer().

            a(_) -> 3.

            b(_) -> a.

            t()-> a.
    
-export([a/1]).

            -spec a(_A) -> boolean() when
                  _ :: atom(),
                  _A :: integer().

            a(_) -> true.
    

            -spec a(_) -> ok.
            -spec a(_) -> ok.

            -spec ?MODULE:a(_) -> ok.
            -spec ?MODULE:a(_) -> ok.
    
-export_type([r1/0]).
              -type r1() :: erl_scan:line()
                          | erl_scan:column()
                          | erl_scan:location()
                          | erl_anno:line().
-export_type([r1/0]).
              -compile(nowarn_deprecated_type).
              -type r1() :: erl_scan:line()
                          | erl_scan:column()
                          | erl_scan:location()
                          | erl_anno:line().