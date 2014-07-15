function y = g(x)
    if x < 2 then
        y = 2*x-3
    else
        y = x-3+2
    end
endfunction

plot(-5:5, g)
