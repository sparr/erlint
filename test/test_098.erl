-deprecated([{frutt,0,next_version}]).
             -deprecated([{does_not_exist,1}]).
             -deprecated('foo bar').
             -deprecated(module).
             -deprecated([{f,'_'}]).
             -deprecated([{t,0}]).
             -deprecated([{t,'_',eventually}]).
             -deprecated([{'_','_',never}]).
             -deprecated([{{badly,formed},1}]).
             -deprecated([{'_','_',next_major_release}]).
             -deprecated([{atom_to_list,1}]).
             -export([t/0]).
             frutt() -> ok.
             t() -> ok.
            

