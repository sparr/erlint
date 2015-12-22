-module(t).
                    -export([foo/1]).
                    -record(sipurl,  {host :: string()}).
                    -record(keylist, {list = [] :: [_]}).
                    -type sip_headers() :: #keylist{}.
                    -record(request, {uri :: #sipurl{}, header :: sip_headers()}).

                    foo(#request{}) -> ok.
                  

