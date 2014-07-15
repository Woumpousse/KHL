function R = gemiddelde(M)
    [h, w] = length(M)
    
    R = sum(M) / (h*w)
endfunction
