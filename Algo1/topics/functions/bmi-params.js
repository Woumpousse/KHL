function berekenBMI(`\NODE[inner sep=1pt,fill=red!50]{gewicht}{param weight}`, `\NODE[inner sep=1pt,fill=red!50]{lengte}{param length}`) {
    bmi = gewicht / (lengte * lengte);
}

var gewichtJan = 80, lengteJan = 1.80;
var gewichtPiet = 70, lengtePiet = 1.70;
var bmiJan, bmiPiet;
var bmi;

berekenBMI(`\NODE[inner sep=1pt,fill=red!50]{gewichtJan}{jan weight}`, `\NODE[inner sep=1pt,fill=red!50]{lengteJan}{jan length}`);
bmiJan = bmi;

berekenBMI(`\NODE[inner sep=1pt,fill=red!50]{gewichtPiet}{piet weight}`, `\NODE[inner sep=1pt,fill=red!50]{lengtePiet}{piet length}`);
bmiPiet = bmi;
