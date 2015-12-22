
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
             

