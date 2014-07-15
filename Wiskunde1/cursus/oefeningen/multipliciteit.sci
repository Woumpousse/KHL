function [x, m] = multipliciteit(x, k)
    m = 0
    while modulo(x, k) == 0,
        x = x / k; m = m + 1
    end
endfunction
