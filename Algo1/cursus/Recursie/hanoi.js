function hanoi(hoogte, van,  naar) {
    if (hoogte == 1) {
        verplaats(van, naar);
    } else {
        var reserve = 6 - van - naar;
        hanoi(hoogte - 1, van, reserve);
        verplaats(van, naar);
        hanoi(hoogte - 1, reserve, naar);
    }
}
