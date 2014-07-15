function R = equalsMatrix(M, N)
    [h,w] = size(M)
    [h2,w2] = size(N)
    
    if w <> w2 | h <> h2 then
        R = %f
    else
        R = %t
        
        for i = 1:h
            for j = 1:w
                R = R & M(i,j) == N(i,j)
            end
        end
    end
endfunction
