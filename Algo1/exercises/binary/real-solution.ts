/*
  Dit bestand bevat niet voor elke functie een implementatie
  die aan de opgave voldoet.
*/

module ReferenceImplementations
{
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

    /* TODO! Needs good solution */
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
