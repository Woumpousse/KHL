function [som, term] = sommeetk(a, r, n)
  som = 0; term = a
  for k = 1:n
    som = som + term; term = term * r
  end
  term = term / r
endfunction
