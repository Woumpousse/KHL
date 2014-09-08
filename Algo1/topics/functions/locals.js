function foo() {
    var x = 0;
    x++;
    return x;
}

var a = `\NODE{foo();}{a}`
var b = `\NODE{foo();}{b}`
var c = `\NODE{foo();}{c}`
