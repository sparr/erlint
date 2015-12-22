-behaviour(gen_server).
              -behaviour(supervisor).
              -export([handle_call/3,handle_cast/2,handle_info/2]).
              handle_call(_, _, _) -> ok.
              handle_cast(_, _) -> ok.
              handle_info(_, _) -> ok.
             

