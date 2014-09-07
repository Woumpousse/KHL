function berekenBMI() {
    bmi = gewicht / (lengte * lengte);
}

var gewichtJan = 80, lengteJan = 1.80;
var gewichtPiet = 70, lengtePiet = 1.70;
var bmiJan, bmiPiet;
var bmi;

var `\NODE{gewicht}{copy weight}` = gewichtJan;
var `\NODE{lengte}{copy length}` = lengteJan;
berekenBMI();
bmiJan = `\NODE{bmi}{copy bmi}`;

var `\NODE{gewicht}{copy weight 2}` = gewichtPiet;
var `\NODE{lengte}{copy length 2}` = lengtePiet;
berekenBMI();
bmiPiet = `\NODE{bmi}{copy bmi 2}`;
