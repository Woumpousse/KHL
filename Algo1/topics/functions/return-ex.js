function foo(x) {
    return x * x;
}

var x = 2;
x = foo( foo(x) );
