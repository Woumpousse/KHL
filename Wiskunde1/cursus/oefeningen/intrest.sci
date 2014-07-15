function K = intrest(K, r)
    K = K * (1 + r/100)
endfunction

function [n,K] = aantal(K, r, T)
    n = 0
    K2 = intrest(K, r) - T
    
    while K2 >= 0,
        K = K2
        K2 = intrest(K, r) - T
        n = n + 1
    end
endfunction
