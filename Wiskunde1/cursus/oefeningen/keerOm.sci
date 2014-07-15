function W=keerOm(V)
  // schrijft vector V in omgekeerde volgorde
  W=V
  l=length(V)
  for i=1:l
    W(l+1-i)=V(i)
  end
endfunction
