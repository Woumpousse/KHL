/*
  Dit bestand bevat niet voor elke functie een implementatie
  die aan de opgave voldoet.
*/

function random() : number
{
    return 0;
}

module ReferenceImplementations
{
    export function randomInteger(a : number, b : number) : number
    {
        return Math.floor(random() * (b - a)) + a;
    }

    export function throwDie() : number
    {
        return randomInteger(1, 7);
    }

    export function sumDice(n : number) : number
    {
        var result = 0;

        for ( var i = 0; i !== n; ++i )
        {
            result += throwDie();
        }

        return result;
    }

    export function countSumDice(diceCount : number, n : number, sum : number) : number
    {
        var result = 0;

        for ( var i = 0; i !== n; ++i )
        {
            if ( sumDice(diceCount) === sum )
            {
                ++result;
            }
        }

        return result;
    }

    export function mostFrequentSum(diceCount : number) : number
    {
        var bestSum = 0;
        var bestSumCount = 0;

        for ( var i = 1; i !== 6 * diceCount; ++i )
        {
            var count = countSumDice(diceCount, 1000, i);

            if ( count > bestSumCount )
            {
                bestSumCount = count;
                bestSum = i;
            }
        }

        return bestSum;
    }

    export function product(a : number, b : number) : number
    {
        return a * b;
    }

    export function quotient(a : number, b : number) : any
    {
        if ( a < 0 || b <= 0 )
        {
            return "invalid";
        }
        else
        {
            return Math.floor( a / b );
        }
    }

    export function modulo(a : number, b : number) : any
    {
        if ( a < 0 || b <= 0 )
        {
            return "invalid";
        }
        else
        {
            return a % b;
        }
    }

    export function pow(a : number, b : number) : any
    {
        if ( (a === 0 && b === 0) || b < 0 )
        {
            return "invalid";
        }
        else
        {
            return Math.pow(a, b);
        }
    }

    export function calc(op : string, a : number, b : number) : any
    {
        if ( op === "+" )
        {
            return a + b;
        }
        else if ( op === "*" )
        {
            return product(a, b);
        }
        else if ( op === "/" )
        {
            return quotient(a, b);
        }
        else if ( op === "%" )
        {
            return modulo(a, b);
        }
        else if ( op === "^" )
        {
            return pow(a, b);
        }
        else
        {
            return "invalid";
        }
    }

    export function isBinary(x : number) : boolean
    {
        if ( x < 0 )
        {
            return false;
        }
        else
        {
            while ( x > 0 )
            {
                var lastDigit = x % 10;

                if ( lastDigit > 1 )
                {
                    return false;
                }

                x = ( x - lastDigit ) / 10;
            }

            return true;
        }
    }

    export function binaryToDecimal(x : number) : any
    {
        if ( !isBinary(x) )
        {
            return "invalid";
        }
        else
        {
            var result = 0;
            var weight = 1;
            
            while ( x > 0 )
            {
                var lastDigit = x % 10;

                result += weight * lastDigit;
                x = Math.floor(x / 10);
                weight *= 2;
            }

            return result;
        }        
    }

    export function decimalToBinary(x : number) : any
    {
        if ( x < 0 )
        {
            return "invalid";
        }
        else
        {
            var result = 0;
            var weight = 1;
            
            while ( x > 0 )
            {
                var lastDigit = x % 2;

                result += weight * lastDigit;
                x = Math.floor(x / 2);
                weight *= 10;
            }

            return result;
        }        
    }

    export function binaryAdd(x : number, y : number) : any
    {
        if ( !isBinary(x) || !isBinary(y) )
        {
            return "invalid";
        }
        else
        {
            var decimalX = binaryToDecimal(x);
            var decimalY = binaryToDecimal(y);
            var decimalSum = decimalX + decimalY;
            var binarySum = decimalToBinary(decimalSum);

            return binarySum;
        }
    }
}
