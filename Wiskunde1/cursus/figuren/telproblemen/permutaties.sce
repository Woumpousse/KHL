function r=swap(s,x,y)
  // wissel in vector s element x en y van plaats
  r=s;
  r(y)=s(x);
  r(x)=s(y);
endfunction


function permutatie(n)
  // vind alle permutaties van 1...n 
  // in lexicografische volgorde
  s=1:n;
  disp(s);
  for i=2:factorial(n)
    m=n-1;
    while s(m)>s(m+1)
      // zoek het eerste element dat kleiner is dan het
      // tweede te beginnen van rechts
      m=m-1;
    end
    k=n;
    while s(m)>s(k)
      // vind het meest rechtse element s(k)
      // waarbij s(m)<s(k)
      k=k-1;
    end
    s=swap(s,m,k);
    p=m+1;
    q=n;
    while p<q
      s=swap(s,q,p);
      p=p+1;
      q=q-1;
    end
    disp(s)
  end
endfunction

permutatie(3)
    