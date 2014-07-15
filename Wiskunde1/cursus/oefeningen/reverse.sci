function W = reverse(V, n)
    W = []
    
    for x = V
        for k = 1:n
            W = [x, W]
        end
    end
endfunction
