function R = gemiddelde(M)
    [h, w] = size(M)
    
    R = sum(M) / (h*w)
endfunction
