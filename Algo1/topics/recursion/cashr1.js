function cash(n, x) {
    if ( n === 0 ) {
        return true;
    }
    else {
        return cash(n - 1, x - 1);
    }
}
