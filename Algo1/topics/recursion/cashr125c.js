function cash(n, x, y, z) {
    return n === 0 ||
      (n > 0 && (cash(n - 5, x, y, z - 1) ||
                 cash(n - 2, x, y - 1, 0) ||
                 cash(n - 1, x - 1, 0, 0)));
}
