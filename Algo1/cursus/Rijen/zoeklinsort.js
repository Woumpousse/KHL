function zoekLineair(rij,waarde){
    var gevonden = false, stop = false;
    for (var i = 0; i < rij.length && !stop; i++){
        if (rij[i] == waarde) {
            gevonden = true;
            stop = true;
        } else if (rij[i] > waarde){
            stop = true;
        }
    }
    return gevonden;
}
