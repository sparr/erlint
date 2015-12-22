-record(rec1, {a = #rec2{}}).
             -record(rec2, {a = #rec1{}}).
             t() ->#rec1{}.
            

