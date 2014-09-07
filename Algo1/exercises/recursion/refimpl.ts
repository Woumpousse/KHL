function isVowel(c : string) : boolean
{
    c = c.toLowerCase();

    return /^[aeiou]$/.test(c);
}

module ReferenceImplementations
{
    export function isOdd(n : number) : boolean {
        if ( n < 0 ) {
            isOdd( -n );
        }
        else if ( n === 0 ) {
            return false;
        }
        else if ( n === 1 ) {
            return true;
        }
        else {
            return isOdd(n-2);
        }
    }

    export function factorial(n : number) : number {
        if ( n === 0 ) {
            return 1;
        }
        else {
            return n * factorial(n - 1);
        }
    }

    export function sum(xs : Array<number>) : number {
         if ( xs.length === 0 ) {
            return 0;
        }
        else {
            return xs[0] + sum( xs.slice(1) );
        }
    }

    export function product(xs : Array<number>) : number {
         if ( xs.length === 0 ) {
            return 1;
        }
        else {
            return xs[0] * product( xs.slice(1) );
        }
    }

    export function countZeros(xs : Array<number>) : number {
        if ( xs.length === 0 ) {
            return 0;
        }
        else if ( xs[0] === 0 ) {
            return 1 + countZeros( xs.slice(1) );
        }
        else {
            return countZeros( xs.slice(1) );
        }
    }

    export function removeZeros(xs : Array<number>) : Array<number> {
        if ( xs.length === 0 ) {
            return [];
        }
        else if ( xs[0] === 0 ) {
            return removeZeros( xs.slice(1) );
        }
        else {
            return [ xs[0] ].concat( removeZeros( xs.slice(1) ) );
        }
    }

    export function firstIndexOf<T>(x : T, xs : Array<T>) : number {
        if ( xs.length === 0 ) {
            return -1;
        }
        else if ( x === xs[0] ) {
            return 0;
        }
        else {
            var idx = firstIndexOf(x, xs.slice(1));

            if ( idx == -1 ) {
                return -1;
            }
            else {
                return idx + 1;
            }
        }
    }

    export function removeAt<T>(xs : Array<T>, index : number) : Array<T> {
        if ( xs.length === 0 ) {
            return [];
        }
        else if ( index === 0 ) {
            return xs.slice(1);
        }
        else {
            return [ xs[0] ].concat( removeAt(xs.slice(1), index-1) );
        }
    }

    export function isSubsetOf<T>(xs : Array<T>, ys : Array<T>) : boolean {
        if ( xs.length === 0 ) {
            return true;
        }
        else {
            var idx = firstIndexOf( xs[0], ys );

            return idx !== -1 && isSubsetOf( xs.slice(1), removeAt( ys, idx ) );
        }
    }

    export function range(a : number, b : number) : Array<number> {
        if ( a > b ) {
            return [];
        }
        else {
            return [a].concat( range(a+1, b) );
        }
    }

    export function duplicateEachItem<T>(xs : Array<T>) : Array<T> {
        if ( xs.length === 0 ) {
            return [];
        }
        else {
            return [ xs[0], xs[0] ].concat( duplicateEachItem(xs.slice(1)) );
        }
    }

    export function subarrays<T>(xs : Array<T>) : Array<Array<T>> {
        if ( xs.length === 0 ) {
            return [ [] ];
        }
        else {
            var subresult = subarrays( xs.slice(1) );
            var result = subresult.slice(0);

            for ( var i = 0; i !== subresult.length; ++i ) {
                 result.unshift( [ xs[0] ].concat( subresult[i] ) );
            }

            return result;
        }
    }

    export function permutations<T>(xs : Array<T>) : Array<Array<T>> {
        if ( xs.length === 0 ) {
            return [ [] ];
        }
        else {
            var result = [];

            for ( var i = 0; i !== xs.length; ++i ) {
                var picked = xs[i];
                var rest = xs.slice(0, i).concat( xs.slice(i+1) );

                var restPermutations = permutations( rest );

                for ( var j = 0; j !== restPermutations.length; ++j ) {
                    result.push( [picked].concat( restPermutations[j] ) );
                }
            }

            return result;
        }
    }

    export function knapsack(n : number, ns : Array<number>) : Array<number> {
        if ( n ===  0 ) {
            return [];
        }
        else if ( n < 0 || ns.length == 0 ) {
            return null;
        }
        else {
            var head = ns[0];
            var tail = ns.slice(1);
            var result = knapsack(n - ns[0], ns.slice(1));

            if ( result !== null ) {
                return [head].concat(result);
            }
            else {
                return knapsack(n, ns.slice(1));
            }
        }
    }

    export function vowelCount(str)
    {
        if ( str.length === 0 )
        {
            return 0;
        }
        else
        {
            var head = str.charAt(0);
            var tail = str.substring(1);
            var tailVowelCount = vowelCount(tail);

            if ( isVowel( head ) )
            {
                return 1 + tailVowelCount;
            }
            else
            {
                return tailVowelCount;
            }
        }
    }

    export function maskVowels(str)
    {
        if ( str.length === 0 )
        {
            return "";
        }
        else
        {
            var head = str.charAt(0);
            var tail = str.substring(1);
            var maskedTail = maskVowels(tail);

            if ( isVowel(head) )
            {
                return "*".concat(maskedTail);
            }
            else
            {
                return head.concat(maskedTail);
            }
        }
    }

    export function rle(str)
    {
        // Auxialiry function
        // Can of course also be defined outside this method body
        function aux(str, last, count)
        {
            if ( str.length === 0 )
            {
                return last + count;
            }
            else
            {
                var head = str.charAt(0);
                var tail = str.substring(1);

                if ( head === last )
                {
                    return aux(tail, last, count + 1);
                }
                else
                {
                    return last + count + aux(tail, head, 1);
                }
            }
        }

        if ( str.length === 0 )
        {
            return "";
        }
        else
        {
            var head = str.charAt(0);
            var tail = str.substring(1);
            
            return aux(tail, head, 1);
        }
    }

    export function compress(str)
    {
        // Auxialiry function
        // Can of course also be defined outside this method body
        function aux(str, last, count)
        {
            if ( str.length === 0 )
            {
                return last + count;
            }
            else
            {
                var head = str.charAt(0);
                var tail = str.substring(1);

                if ( head === last )
                {
                    if ( count === 9 )
                    {
                        return head + "9" + aux(tail, head, 1);
                    }
                    else
                    {
                        return aux(tail, head, count + 1);
                    }
                }
                else
                {
                    return last + count + aux(tail, head, 1);
                }
            }
        }

        if ( str.length === 0 )
        {
            return "";
        }
        else
        {
            var head = str.charAt(0);
            var tail = str.substring(1);
            
            return aux(tail, head, 1);
        }
    }

    export function repeat(x, n)
    {
        if ( n === 0 )
        {
            return "";
        }
        else 
        {
            return x.concat( repeat(x, n-1) );
        }
    }

    export function decompress(str)
    {
        if ( str.length === 0 )
        {
            return "";
        }
        else
        {
            var c = str.charAt(0);
            var n = parseInt(str.charAt(1));

            return repeat(c, n).concat( decompress( str.substring(2) ) );
        }
    }
}
