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
             

