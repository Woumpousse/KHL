module Solutions
{
    export function countTrailingZeros(n : number) : number
    {
        var result;

        if ( n === 0 )
        {
            result = 1;
        }
        else
        {
            result = 0;
            while ( n !== 0 && n % 10 === 0 )
            {
                n /= 10;
                result++;
            }
        }

        return result;
    }

    export function countZeros(n : number) : number
    {
        var result;

        if ( n === 0 )
        {
            result = 1;
        }
        else
        {
            if ( n < 0 )
            {
                n = -n;
            }

            result = 0;
            while ( n !== 0 )
            {
                if ( n % 10 === 0 )
                {
                    result++;
                }

                n = Math.floor(n / 10);
            }
        }

        return result;
    }

    export function rangeSum(a : number, b : number) : number
    {
        var result;

        result = 0;

        for ( var i = a; i <= b; ++i )
        {
            result += i;
        }

        return result;
    }

    export function isPrime(n : number) : boolean
    {
        var result;

        if ( n < 2 )
        {
            result = false;
        }
        else
        {
            result = true;
            var i = 2;
            while ( i * i <= n && result )
            {
                if ( n % i === 0 )
                {
                    result = false;
                }

                ++i;
            }
        }

        return result;
    }
}
