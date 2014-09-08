module ReferenceImplementations
{
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
}
