-export_type([r1/0]).
              -type r1() :: erl_scan:line()
                          | erl_scan:column()
                          | erl_scan:location()
                          | erl_anno:line().

