module ReferenceImplementations
{
    export function average(a : number, b : number) : number
    {
        var result;

        result = (a + b) / 2;

        return result;
    }

    export function isOdd(n : number) : boolean
    {
        var result;

        if ( n % 2 ==+ 1 )
        {
            result = true;
        }
        else
        {
            result = false;
        }

        return result;
    }

    export function isEven(n : number) : boolean
    {
        var result;

        if ( n % 2 ==+ 0 )
        {
            result = true;
        }
        else
        {
            result = false;
        }

        return result;
    }

    export function endsInZero(n : number) : boolean
    {
        var result;
        
        if ( n % 10 === 0 )
        {
            result = true;
        }
        else
        {
            result = false;
        }

        return result;
    }


    export function endsInThreeZeros(n : number) : boolean
    {
        var result;
        
        if ( (n <= -1000 || n >= 1000) && n % 1000 === 0 )
        {
            result = true;
        }
        else
        {
            result = false;
        }

        return result;
    }


    export function minimumOfTwo(a : number, b : number) : number
    {
        var result;
        
        if ( a < b )
        {
            result = a;
        }
        else
        {
            result = b;
        }

        return result;
    }

    export function abs(a : number) : number
    {
        var result;

        if ( a >= 0 )
        {
            result = a;
        }
        else
        {
            result = -a;
        }

        return result;
    }

    export function maximumOfThree(a : number, b : number, c : number) : number
    {
        var result;

        if ( a >= b && a >= c )
        {
            result = a;
        }
        else if ( b >= a && b >= c )
        {
            result = b;
        }
        else
        {
            result = c;
        }

        return result;
    }

    export function sort(a : number, b : number, c : number) : Array<number>
    {
        var x, y, z;

        if ( a <= b && a <= c )
        {
            x = a;

            if ( b <= c )
            {
                y = b;
                z = c;
            }
            else
            {
                y = c;
                z = b;
            }
        }
        else if ( b <= a && b <= c )
        {
            x = b;

            if ( a <= c )
            {
                y = a;
                z = c;
            }
            else
            {
                y = c;
                z = a;
            }
        }
        else
        {
            x = c;

            if ( a <= b )
            {
                y = a;
                z = b;
            }
            else
            {
                y = b;
                z = a;
            }
        }
              
        return [x, y, z];
    }            

    export function cost1(n : number) : number
    {
        var result;

        result = n * 5;

        return result;
    }

    export function cost2(n : number, k : number) : number
    {
        var result;

        result = n * 5 + k * 7;

        return result;
    }

    export function cost3(n : number, k : number) : number
    {
        var result;

        result = n * 5 + k * 7 + 0.5 * (n + k);

        return result;
    }

    export function cost4(n : number, k : number) : number
    {
        var result;

        result = n * 5 + k * 7;

        if ( n + k < 3 )
        {
            result += 0.5 * (n + k);
        }

        return result;
    }

    export function cost5(n : number, k : number) : number
    {
        var result;

        result = n * 5 + k * 7;

        if ( result < 20 || n + k < 3 )
        {
            result += 0.5 * (n + k);
        }

        return result;
    }

    // TODO
    export function bookOrder(n : number) : number
    {
        var result;

        var price;
        if ( n < 100 ) price = 50;
        else if ( n < 250 ) price = 45;
        else if ( n < 500 ) price = 40;
        else if ( n < 1000 ) price = 30;

        result = n * price;

        return result;
    }

    // TODO
    export function taxes(n : number) : number
    {
        var result;

        result = 0;
        
        n -= 1000;
        if ( n > 0 )
        {
            result += (n % 500) * 0.25;
            n -= 500;

            if ( n > 500 )
            {
                result += n * 0.50;
            }
        }


        return result;
    }
}
