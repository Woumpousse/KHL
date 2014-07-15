function [y, x] = swap(x, y)
endfunction

function r = ggd(D,d)
    while d <> 0
        D = modulo(D, d)
        [D, d] = swap(D, d)
    end
    
    r = D
endfunction
