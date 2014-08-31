var last = 1;
function nextRandom() {
    last = ((last * last * 101) - 31) % 97;
    return last;
}
