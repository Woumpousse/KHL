var aantal =
  parseInt(prompt("Tot waar moet ik de som berekenen?"));
var som = 0;
for(var i = 1; i < aantal; i++) {
    som += i;
}
alert("De totale som is " + som);
