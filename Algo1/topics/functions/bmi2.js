function berekenBMI() {
    `\NODE{bmi}{set bmi}` = gewicht / (lengte * lengte);
}

function evalueerBMI() {
    if ( bmi > 25 ) {
        `\NODE{resultaat}{set result 1}` = "te dik!";
    } else {
        `\NODE{resultaat}{set result 2}` = "ok";
    }
}

var gewicht = 80, lengte = 1.80;
var bmi, resultaat;
`\NODE{berekenBMI();}{compute bmi}`
`\NODE{evalueerBMI();}{evaluate bmi}`
