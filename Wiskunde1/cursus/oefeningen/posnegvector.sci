function R = posnegvector(n)
    R = []
    x = 1
    k = 0
    while k < n & x <> 0,
        x = input('Geef getal in: ')
        if x < 0 then
            x = -1
        end
        
        if x <> 0 then
          R = [R, x]
          k = k + 1
        end
    end
endfunction
