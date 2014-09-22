var som = 0;
var getal = parseInt(prompt("Geef het eerste getal."));
while(getal >= 0) {
    som += getal;
    getal = parseInt(prompt("Geef het volgende getal."));
}
alert("De totale som is " + som);
