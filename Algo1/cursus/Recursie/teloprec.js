function telOp(n) {
    var resultaat;
    if(n == 0) {
        resultaat = 0;
    } else {
        resultaat = telOp(n-1) + n;
    }
    return resultaat;
}
