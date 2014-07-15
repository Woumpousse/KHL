function n = aantalElementenGroterDanGemiddelde(V)
    g = gemiddelde(V)
    n = 0
    
    for col = V
        for x = col'
            if x > g then
                n = n + 1
            end
        end
    end
endfunction
