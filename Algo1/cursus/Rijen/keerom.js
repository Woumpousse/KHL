function keerOm(rij) {
    for (var i = 0;i < (rij.length / 2); i++) {
        var hulp = rij[i];
        rij[i] = rij[rij.length - 1 - i];
        rij[rij.length - 1 - i] = hulp;
    }
}

var aRij= [1,2,3,4,5];
keerOm(aRij);
