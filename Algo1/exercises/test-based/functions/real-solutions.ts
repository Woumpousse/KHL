function random() : number
{
    return 0;
}

module Solutions
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
        if ( a < 0 )
        {
            a = -a;
            b = -b;
        }

        var result = 0;
        while ( a > 0 ) {
            result += b;
            a--;
        }

        return result;
    }

    export function quotient(a : number, b : number) : any
    {
        if ( a < 0 || b <= 0 )
        {
            return "invalid";
        }
        else
        {
            var result = 0;

            while ( product(result, b) <= a )
            {
                result++;
            }

            return result - 1;
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
            return a - quotient(a, b) * b;
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
            var result = 1;

            while ( b > 0 )
            {
                result = product(result, a);
                --b;
            }

            return result;
        }
    }

    export function calc(op : string, a : number, b : number) : any
    {
        if ( op === "+" )
        {
            return a + b;
        }
        else if ( op === "-" )
        {
            return a - b;
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
}
