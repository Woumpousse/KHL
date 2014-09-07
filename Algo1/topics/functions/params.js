function foo(`\NODE{\paramx}{paramx}`, `\NODE{\paramy}{paramy}`, `\NODE{\paramz}{paramz}`) {
    `\NODE{bar}{bar}` = `\NODE{\paramx}{x}` + `\NODE{\paramy}{y}` * `\NODE{\paramz}{z}`;
}

var `\NODE{\localx}{localx}` = 1;
var `\NODE{\localy}{localy}` = 2;
var `\NODE{\localz}{localz}` = 3;
var bar;

foo(`\NODE{\argx}{argx}`, `\NODE{\argy}{argy}`, `\NODE{\argz}{argz}`);
