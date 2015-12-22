-record(r1, {a = begin A = 4, {A,B} end}). % B unbound
              -record(r2, {e = begin A = 3, #r1{} end}).
              t() -> #r2{}.
             

