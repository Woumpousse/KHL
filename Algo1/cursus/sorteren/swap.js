function verwissel(rij, i, j) {
    var kopie = rij[i];
    rij[i] = rij[j];
    rij[j] = kopie;
}
