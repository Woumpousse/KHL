function maakTijdstip(uur, min, sec) {
    return [`\NODE{uur}{init hour}`, `\NODE{min}{init min}`, `\NODE{sec}{init sec}`];
}

function getUur(tijdstip) {
    return tijdstip[`\NODE{0}{hour index}`];
}

function getMinuten(tijdstip) {
    return tijdstip[`\NODE{1}{minute index}`];
}

function getSeconden(tijdstip) {
    return tijdstip[`\NODE{2}{second index}`];
}
