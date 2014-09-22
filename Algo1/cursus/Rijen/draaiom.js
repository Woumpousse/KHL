function draaiOm(rij){
    var rijOmgekeerd = new Array(rij.length);
    for (var i= 0 ; i < rij.length; i++) {
        rijOmgekeerd[rij.length - i - 1]  = rij[i];
    }
    return rijOmgekeerd;
}
