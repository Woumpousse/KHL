function gelukkig(n) {
    var bezocht = nieuweVerzameling();

    while ( !elementVan(n, bezocht) &&
            n !== 1 )
    {
        voegToe(bezocht, n);
        n = opvolger(n);
    }

    return n === 1;
}
