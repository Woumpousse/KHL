function [x, m] = multipliciteit(x, k)
    m = 0
    
    while modulo(x, k) == 0,
        x = x / k; m = m + 1
    end
endfunction

function [ps, ms] = zoekdelers(x, v)
    ps = []; ms = []    
    
    for p = v
        [x, m] = multipliciteit(x, p)
        
        if m > 0 then
            ps = [ ps, p ]; ms = [ ms, m ]
        end
    end
endfunction
