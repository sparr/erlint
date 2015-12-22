-export_type([r1/0]).
              -compile(nowarn_deprecated_type).
              -type r1() :: erl_scan:line()
                          | erl_scan:column()
                          | erl_scan:location()
                          | erl_anno:line().

