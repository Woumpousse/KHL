module ReferenceImplementations
{
    export function contains(xs : Array<any>, x : any) : boolean
    {
        for ( var i = 0; i !== xs.length; ++i )
        {
            if ( xs[i] === x )
            {
                return true;
            }
        }
        
        return false;
    }

    export function sum(xs : Array<number>) : number
    {
        var result = 0;

        for ( var i = 0; i !== xs.length; ++i )
        {
            result += xs[i];
        }

        return result;
    }

    export function product(xs : Array<number>) : number
    {
        var result = 1;

        for ( var i = 0; i !== xs.length; ++i )
        {
            result *= xs[i];
        }

        return result;
    }

    export function average(xs : Array<number>) : number
    {
        return sum(xs) / xs.length;
    }

    export function incrementEachItem(xs : Array<number>) : void
    {
        for ( var i = 0; i !== xs.length; ++i )
        {
            xs[i]++;
        }
    }

    export function countZeros(xs : Array<any>) : number
    {
        var result = 0;

        for ( var i = 0; i !== xs.length; ++i )
        {
            if ( xs[i] === 0 )
            {
                ++result;
            }
        }

        return result;
    }

    export function firstIndexOf(x : any, xs : Array<any>) : number
    {
        for ( var i = 0; i !== xs.length; ++i )
        {
            if ( xs[i] === x )
            {
                return i;
            }
        }

        return -1;
    }

    export function lastIndexOf(x : any, xs : Array<any>) : number
    {
        for ( var i = xs.length - 1; i >= 0; --i )
        {
            if ( xs[i] === x )
            {
                return i;
            }
        }

        return -1;
    }

    export function range(a : number, b : number) : Array<number>
    {
        if ( a > b )
        {
            return [];
        }
        else
        {
            var result = new Array(b - a + 1);

            for ( var i = 0; i !== result.length; ++i ) {
                result[i] = a + i;
            }

            return result;
        }
    }

    export function reverse(xs : Array<any>) : void
    {
        for ( var i = 0; 2 * i < xs.length; ++i )
        {
            var j = xs.length - i - 1;

            var temp = xs[i];
            xs[i] = xs[j];
            xs[j] = temp;
        }
    }

    export function isPalindrome(xs : Array<any>) : boolean
    {
        for ( var i = 0; i < xs.length / 2; ++i )
        {
            if ( xs[i] !== xs[xs.length - i - 1] )
            {
        	return false;
            }
        }

        return true;
    }

    export function minimum(xs : Array<number>) : number
    {
        var result = xs[0];

        for ( var i = 1; i < xs.length; ++i )
        {
            if ( xs[i] < result )
            {
        	result = xs[i];
            }
        }

        return result;
    }

    export function maximum(xs : Array<number>) : number
    {
        var result = xs[0];

        for ( var i = 1; i < xs.length; ++i )
        {
            if ( xs[i] > result )
            {
                result = xs[i];
            }
        }

        return result;
    }

    export function isIncreasing(xs : Array<number>) : boolean
    {
        if ( xs.length === 0 )
        {
            return true;
        }
        else
        {
            var last = xs[0];

            for ( var i = 0; i !== xs.length; ++i )
            {
                if ( xs[i] < last )
                {
                    return false;
                }
                else
                {
                    last = xs[i];
                }
            }

            return true;
        }
    }

    export function isDecreasing(xs : Array<number>) : boolean
    {
        if ( xs.length === 0 )
        {
            return true;
        }
        else
        {
            var last = xs[0];

            for ( var i = 0; i !== xs.length; ++i )
            {
                if ( xs[i] > last )
                {
                    return false;
                }
                else
                {
                    last = xs[i];
                }
            }

            return true;
        }
    }

    export function areEqual<T>(xs : Array<T>, ys : Array<T>) : boolean
    {
        if ( xs.length !== ys.length )
        {
            return false;
        }
        else
        {
            for ( var i = 0; i !== xs.length; ++i )
            {
                if ( xs[i] !== ys[i] )
                {
                    return false;
                }
            }

            return true;
        }
    }

    export function alternates<T>(xs : Array<T>) : Array<Array<T>>
    {
        var result = [ [], [] ];

        for ( var i = 0; i !== xs.length; ++i )
        {
            result[ i % 2 ].push( xs[i] );
        }

        return result;
    }

    export function lengthOfLongestIncreasingSubarray(xs : Array<number>) : number
    {
        if ( xs.length === 0 )
        {
            return 0;
        }
        else
        {
            var result = 1;
            var currentMaximalLength = 1;
            var lastValue = xs[0];
            
            for ( var i = 1; i < xs.length; ++i )
            {
                var currentValue = xs[i];
                
                if ( currentValue >= lastValue )
                {
                    currentMaximalLength++;

                    if ( currentMaximalLength > result )
                    {
                        result = currentMaximalLength;
                    }
                }
                else
                {
                    currentMaximalLength = 1;
                }
                
                lastValue = currentValue;
            }
            
            return result;
        }
    }
}
