function zoekLineair(rij,waarde){
    var gevonden = false;
    for (var i = 0; i < rij.length && !gevonden; i++){
        if (rij[i] == waarde){
            gevonden = true;
        }
    }
    return gevonden;
}

