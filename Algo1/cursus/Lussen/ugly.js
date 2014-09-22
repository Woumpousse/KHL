for(var som = 0,
        getal = parseInt(prompt("Geef het eerste getal."));
    getal >= 0;
    getal = parseInt(prompt("Geef het volgende getal."))) {
    som += getal;
}
alert("De totale som is " + som);
