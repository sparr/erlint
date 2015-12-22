-module(p2).
            -export([manifest/2]).
            manifest(Module, Name) ->
              fun Module:Nine/1.
         

