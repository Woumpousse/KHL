function [som, term] = sommeetk(a, r, n)
  som = 0; term = a; k = 1
  while k <= n,
    som = som + term; term = term * r; k = k + 1
  end
  term = term / r
endfunction
