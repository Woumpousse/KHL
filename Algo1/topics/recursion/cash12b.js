function cash(n, x, y) {
    return 2 * y + x >= n &&
           (x > 0 || n % 2 == 0);
}
