function R = elementenGroterDanGemiddelde(M)
    g = gemiddelde(M)
    R = []
    
    for col = M
        for x = col'
            if x > g then
                R = [R, x]
            end
        end
    end
endfunction
