function W=cijfers(V)
  // output initialiseren
  W=[];
  // controleren of V enkel cijfers 0:9 bevat
  for i=1:length(V)
    if (V(i)<0)|(V(i)>9)
      disp('input mag enkel cijfers tussen 0 en 9 bevatten')
      abort // foute input, dus functie afbreken
    end
  end
  // cijfer per cijfer controleren of het voorkomt in V
  for i=0:9
    for j=1:length(V)
      if V(j)==i
        W=[W,i] // cijfer komt voor, dus plakken aan output-vector
        break // cijfer is gevonden, dus niet meer verder zoeken
        // voor dit cijfer
      end
    end
  end
endfunction
