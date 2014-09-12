function cash(n, x, y, z) {
    if ( n === 0 ) { return true; }
    else {
        return cash(n - 1, x - 1, y, z) ||
               cash(n - 2, x, y - 1, z) ||
               cash(n - 5, x, y, z - 1);
    }
}
