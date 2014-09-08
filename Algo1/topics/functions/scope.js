function foo() {
    var `\NODE{x}{foo x}` = 1;
    alert(`\NODE{x}{foo ref x}`);
}

function bar() {
    var `\NODE{x}{bar x}` = 2;
    alert(`\NODE{x}{bar ref x}`);
}

function qux() {
    `\NODE{x}{qux x}` = 2;
    alert(`\NODE{x}{qux ref x}`);
}


var `\NODE{x}{global x}` = 3;
alert(`\NODE{x}{global ref x}`);
