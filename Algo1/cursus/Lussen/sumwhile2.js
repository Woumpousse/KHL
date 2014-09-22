var aantal =
  parseInt(prompt("Tot waar moet ik de som berekenen?"));
var som = 0;
var i = 1;
while(i < aantal) {
    som += i;
    i++;
}
alert("De totale som is " + som);
