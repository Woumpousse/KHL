var lower = 20;
var upper = 40;
var guess = (lower + upper) / 2;
var guessSqr = guess * guess;
while ( Math.abs(guessSqr - 1000) > 0.00001 ) {
    if ( guessSqr < 1000 )
        lower = guess;
    else
        upper = guess;

    guess    = (lower + upper) / 2;
    guessSqr = guess * guess;
}

alert( guess );
