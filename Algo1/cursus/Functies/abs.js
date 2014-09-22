// berekenAbsoluteWaarde berekent de absolute waarde van de
// parameter getal en geeft deze terug
function berekenAbsoluteWaarde(getal) {
    var resultaat;
    if (getal < 0) {
        resultaat = -getal;
    } else {
        resultaat = getal;
    }
    return resultaat;
}
