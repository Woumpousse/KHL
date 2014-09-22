function aantalPriemgetallen(n) {
    var aantal = 0;
    for(var i = 2; i <= n; i++) {
        var isPriemgetal = true;
        for(var j = 2; j < i; j++) {
            if (i % j == 0) {
                isPriemgetal = false;
            }
        }
        if (isPriemgetal) {
            aantal++;
        }
    }
    return aantal;
}
