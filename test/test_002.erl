-record(r, {x,y}).
              f({X,Y}) -> {Z=X,Z=Y};
              f([H|T]) -> [Z=H|Z=T];
              f(#r{x=X,y=Y}) -> #r{x=A=X,y=A=Y}.
              g({M, F}) -> (Z=M):(Z=F)();
              g({M, F, Arg}) -> (Z=M):F(Z=Arg).
              h(X, Y) -> (Z=X) + (Z=Y).

