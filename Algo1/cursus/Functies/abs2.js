function berekenAbsoluteWaarde(getal) {
    if (getal < 0) {
        getal = -getal;
    }
    return getal;
}

var invoer = parseInt(prompt("Geef een getal"));
var absGetal = berekenAbsoluteWaarde(invoer);
alert("De absolute waarde van " + invoer + " is " + absGetal);
