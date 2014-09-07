function foo() {
    for ( var i = 0; i !== 5; ++i ) {
        return i;
    }
}

var x = foo();
// x === 0
