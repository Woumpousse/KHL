function vroeger(t1, t2) {
    if ( t1[0] < t2[0] ) {
        return true;
    }
    else if ( t1[0] === t2[0] &&
              t1[1] < t2[1] ) {
        return true;
    }
    else if ( t1[0] === t2[0] &&
              t1[1] === t2[1] &&
              t1[2] < t1[2] ) {
        return true;
    }
    else {
        return false;
    }
}
