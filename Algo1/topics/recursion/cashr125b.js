function cash(n, x, y, z) {
    if ( n === 0 ) {
        return true;
    }
    else if ( `\NODE{n < 0}{negative check}` ) {
        return false;
    }
    else {
        return cash(n - `\NODE{5}{five}`, x, y, z - 1) ||
               cash(n - 2, x, y - 1, `\NODE{0}{zero 1}`) ||
               cash(n - 1, x - 1, `\NODE{0}{zero 2}`, `\NODE{0}{zero 3}`);
    }
}
