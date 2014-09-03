var x = 1;`\COORD{x init}`
var i = 5;`\COORD{i init}`

while ( `\NODE{i > 0}{condition}` ) {
    `\NODE{x *= 2;}{x mul 2}`
    `\NODE{i--;}{i dec}`
}
