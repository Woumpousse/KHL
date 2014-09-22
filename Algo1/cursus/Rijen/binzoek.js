function binairZoeken(rij, waarde){
    var gevonden = false;
    var l = 0; // linkergrens
    var r = rij.length - 1; // rechtergrens
    while (l <= r && !gevonden) {
        var m = Math.floor((l + r) / 2); // midden
        if (rij[m] == waarde) {
            gevonden = true;
        } else if (waarde < rij[m]) {
            r = m - 1; // rechtergrens aanpassen zodat enkel
                       // linkerhelft wordt beschouwd
        }  else {
            l = m + 1; // linkergrens aanpassen zodat enkel
                       // rechterhelft wordt beschouwd
        }
    }
    return gevonden;
}
