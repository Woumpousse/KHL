function tijdsduur(t1, t2) {
    var s1 = t1[0] * 3600 +
             t1[1] * 60 +
             t1[2];

    var s2 = t2[0] * 3600 +
             t2[1] * 60 +
             t2[2];

    return s2 - s1;
}
