-record(r1, {t = case foo of _ -> 3 end}).
              -record(r2, {a = case foo of A -> A; _ -> 3 end}).
              -record(r3, {a = case foo of A -> A end}).
              -record(r4, {a = fun _AllowedFunName() -> allowed end}).
              t() -> {#r1{},#r2{},#r3{},#r4{}}.
             

