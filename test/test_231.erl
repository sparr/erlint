
    -type m() :: #{a => integer()}.
    -spec t1(#{k=>term()}) -> {term(), map()}.

    t1(#{k:=V}=M) -> {V,M}.

    -spec t2(m()) -> integer().

    t2(#{a:=V}) -> V.
    

