function y=zoek(R,x)
  y=0;
  i=1;
  // zoek x in de rij R
  while (i<=length(R))&(R(i)<>x)
    i=i+1;
  end;
  // als x gevonden is, geef juiste return
  if (i<=length(R))
    y=i;
  end
endfunction

R=1:10;
zoek(R,20)