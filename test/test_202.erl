
              -optional_callbacks([{b1,1,bad}]). % badly formed
              -callback b(_) -> atom().
             

