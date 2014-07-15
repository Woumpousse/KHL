function R = EuroNaarEurocent(V)
    R = V(1) * 100 + V(2)
endfunction

function R = EurocentNaarEuro(x)
    R = [ floor(x / 100), modulo(x, 100) ]
endfunction

function R = GeefTerug(V,W)
    x = EuroNaarEurocent(V)
    y = EuroNaarEurocent(W)
    R = EurocentNaarEuro(x - y)
endfunction
