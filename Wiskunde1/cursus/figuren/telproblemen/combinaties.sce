function y=C(r,n)
  y=factorial(n)/(factorial(r)*factorial(n-r))
endfunction


function combination(r,n)
  s=1:r;
  disp(s);
  for i=2:C(r,n)
    m=r;
    max_val=n;
    while s(m)==max_val
      m=m-1;
      max_val=max_val-1;
    end
    s(m)=s(m)+1;
    for j=m+1:r
      s(j)=s(j-1)+1;
    end
    disp(s)
  end
endfunction

combination(2,5)