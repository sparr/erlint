t(#{ a := 2,
               #{} := A,
               #{ 3 => 33 } := hi,
               #{ 3 := 33 } := hi,
               #{ hi => 54, \"hello\" => 45 } := hi,
           #{ V => 33 } := hi }) ->
           A.
       

