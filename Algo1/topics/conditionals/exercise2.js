var `\NODE{x = 3;}{assign x 3}`
var `\NODE{y;}{declare y}`

if ( `\NODE{x < 5}{condition 1}` ) {
    if ( `\NODE{x < 2}{condition 2}` ) {
        y = 1;
    }
    else {
        `\NODE{y = 2;}{assign y 2}`
    }
}
`\COORD{exit}`
