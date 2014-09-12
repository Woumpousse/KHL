function cash(n, x, y) {
    if ( n === 0 ) {
        return true;
    }
    else {
        return cash(n - 1, x - 1, y) ||
               cash(n - 2, x, y - 1);
    }
}
