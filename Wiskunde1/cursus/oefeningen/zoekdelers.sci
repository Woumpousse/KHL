function [ps, ms] = zoekdelers(x, v)
    ps = []; ms = []    
    for p = v
        [x, m] = multipliciteit(x, p)
        
        if m > 0 then
            ps = [ ps, p ]; ms = [ ms, m ]
        end
    end
endfunction
