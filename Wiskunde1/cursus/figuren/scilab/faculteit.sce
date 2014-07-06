function V=facvector(x)
// bereken faculteit van 1 t.e.m. x
 
 if x<0; 
   error("faculteit van negatief getal bestaat niet.",2)
 // foutmelding
  else
    V=zeros(1,x); // vector definieren
    V(1)=1;       // fac(1)=1
    for i= 2 : x
      V(i)=V(i-1)*i;
    end
  end;
endfunction

facvector(-3)

function V=facvector2(x)
// bereken faculteit van 1 t.e.m. x
 
 if x<0; 
   disp("faculteit van negatief getal bestaat niet: de input is "+string(x))
    abort
 // foutmelding
  else
    V=zeros(1,x); // vector definieren
    V(1)=1;       // fac(1)=1
    for i= 2 : x
      V(i)=V(i-1)*i;
    end
  end;
endfunction


facvector2(-3)
