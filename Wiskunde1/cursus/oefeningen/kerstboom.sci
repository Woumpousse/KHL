function y = kerstboom()
    y = 2003
    lengte = 1
    
    while lengte <= 2.30,
        y = y + 1
        lengte = lengte + 0.3
    end
    
    printf("Met kerstmis in het jaar %d zult u " +
           "een nieuwe kerstboom moeten kopen.", y)
endfunction
