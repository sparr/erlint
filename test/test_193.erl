
              -optional_callbacks([b1/1]). % non-existing
              -callback b(_) -> atom().
              behaviour_info(callbacks) -> [{b1,1}].
             

