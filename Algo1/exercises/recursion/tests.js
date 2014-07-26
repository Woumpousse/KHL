/*
  If false, no test cases are shown for X if no function for X has been defined.
*/
var forceShow = false;

function deepEqualChecker(assert, input, expected, received, message) {
    assert.deepEqual(expected, received, message);
}

function permutationChecker(assert, input, expected, received, message) {
    assert.ok( expected !== undefined && expected.isPermutationOf(received), message );
}

var tests = ( function() {
    function isOdd(n) {
        if ( n === 0 ) {
            return false;
        }
        else if ( n === 1 ) {
            return true;
        }
        else {
            return isOdd(n-2);
        }
    }

    function factorial(n) {
        if ( n === 0 ) {
            return 1;
        }
        else {
            return n * factorial(n - 1);
        }
    }

    function sum(xs) {
         if ( xs.length === 0 ) {
            return 0;
        }
        else {
            return xs[0] + sum( xs.slice(1) );
        }
    }

    function product(xs) {
         if ( xs.length === 0 ) {
            return 1;
        }
        else {
            return xs[0] * product( xs.slice(1) );
        }
    }

    function countZeros(xs) {
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

    function removeZeros(xs) {
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

    function firstIndexOf(x, xs) {
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

    function removeAt(xs, index) {
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

    function isSubsetOf(xs, ys) {
        if ( xs.length === 0 ) {
            return true;
        }
        else {
            var idx = firstIndexOf( xs[0], ys );

            return idx !== -1 && isSubsetOf( xs.slice(1), removeAt( ys, idx ) );
        }
    }

    function range(a, b) {
        if ( a > b ) {
            return [];
        }
        else {
            return [a].concat( range(a+1, b) );
        }
    }

    function duplicateEachItem(xs) {
        if ( xs.length === 0 ) {
            return [];
        }
        else {
            return [ xs[0], xs[0] ].concat( duplicateEachItem(xs.slice(1)) );
        }
    }

    function subarrays(xs) {
        if ( xs.length === 0 ) {
            return [ [] ];
        }
        else {
            var subresult = subarrays( xs.slice(1) );
            var result = subresult.slice(0);

            for ( var i = 0; i !== subresult.length; ++i ) {
                 result.push( [ xs[0] ].concat( subresult[i] ) );
            }

            return result;
        }
    }

    function permutations(xs) {
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

    function knapsack(n, ns) {
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

    return { isOdd: { referenceImplementation: isOdd,
                      inputs: [ [0],
                                [1],
                                [2],
                                [3],
                                [4],
                                [5],
                                [100],
                                [101]
                              ]
                    },
             factorial: { referenceImplementation: factorial,
                          inputs: [ [0],
                                    [1],
                                    [2],
                                    [3],
                                    [4],
                                    [5] ]
                        },
             sum: { referenceImplementation: sum,
                    inputs: [ [ [] ],
                              [ [0] ],
                              [ [1] ],
                              [ [1,2] ],
                              [ [1,2,3] ],
                              [ [1,2,3,4,5,6,7,8,9,10] ]
                         ]
                  },
             product: { referenceImplementation: product,
                        inputs: [ [ [] ],
                                  [ [0] ],
                                  [ [1] ],
                                  [ [1,2] ],
                                  [ [1,2,3] ],
                                  [ [1,2,3,4,5,6,7,8,9,10] ],
                                  [ [1,2,3,4,0] ]
                             ]
                      },
             countZeros: { referenceImplementation: countZeros,
                           inputs: [ [ [] ],
                                     [ [0] ],
                                     [ [1] ],
                                     [ [0,0] ],
                                     [ [1,1] ],
                                     [ [1,0,1] ],
                                     [ [0,1,0] ],
                                     [ [1,0,0] ],
                                     [ [2,3,4] ]
                                ]
                         },
             removeZeros: { referenceImplementation: removeZeros,
                            inputs: [ [ [] ],
                                      [ [0] ],
                                      [ [1] ],
                                      [ [0,0] ],
                                      [ [1,1] ],
                                      [ [1,0,1] ],
                                      [ [0,1,0] ],
                                      [ [1,0,0] ],
                                      [ [2,3,4] ]
                                 ]
                          },
             firstIndexOf: { referenceImplementation: firstIndexOf,
                             inputs: [ [ 1, [] ],
                                       [ 1, [1] ],
                                       [ 1, [2] ],
                                       [ 2, [2] ],
                                       [ 2, [1,2,3] ],
                                       [ 3, [1,2,3] ],
                                       [ 4, [1,2,3] ]
                                     ]
                           },
             removeAt: { referenceImplementation: removeAt,
                         inputs: [ [[0], 0],
                                   [[1], 0],
                                   [[], 0],
                                   [[1,2,3], 0],
                                   [[1,2,3], 1],
                                   [[1,2,3], 2],
                                   [[1,2,3], 3]
                                 ]
                       },
             isSubsetOf: { referenceImplementation: isSubsetOf,
                           inputs: [ [ [], [] ],
                                     [ [], [1] ],
                                     [ [1], [1] ],
                                     [ [1,1], [1] ],
                                     [ [1], [1, 1] ],
                                     [ [1], [2] ],
                                     [ [1], [1,2] ],
                                     [ [1], [2,1] ],
                                     [ [1,2], [1,2] ],
                                     [ [1,2], [2,1] ],
                                     [ [1,2,3], [1,2,3] ],
                                     [ [1,2,3], [1] ],
                                     [ [1,2,3], [1,1,2] ],
                                     [ [1,2,3], [3,2,1] ],
                                     [ [1,2,3], [2,3,1] ],
                                     [ [1,2,3], [1,1,2,2,3,3] ]
                                   ]
                         },
             duplicateEachItem: { referenceImplementation: duplicateEachItem,
                                  inputs: [ [ [] ],
                                            [ [0] ],
                                            [ [1] ],
                                            [ [1,2] ],
                                            [ [1,2,3] ],
                                            [ [1,1,2,2] ]
                                          ]
                             },
             range: { referenceImplementation: range,
                      inputs: [ [1,1],
                                [1,2],
                                [1,3],
                                [2,2],
                                [2,4],
                                [1,10]
                              ]
                    },
             subarrays: { referenceImplementation: subarrays,
                          inputs: [ [ [] ],
                                    [ [1] ],
                                    [ [1,2] ],
                                    [ [1,2,3] ]
                                  ],
                          checker: permutationChecker
                        },
             permutations: { referenceImplementation: permutations,
                             inputs: [ [ [] ],
                                       [ [1] ],
                                       [ [1,2] ],
                                       [ [1,2,3] ],
                                       [ [1,2,3,4] ]
                                     ],
                             checker: permutationChecker
                           },
             knapsack: { referenceImplementation: knapsack,
                         inputs: [ [ 0, [] ],
                                   [ 0, [1] ],
                                   [ 1, [1] ],
                                   [ 2, [1,1] ],
                                   [ 2, [1,2] ],
                                   [ 2, [1] ],
                                   [ 7, [1,2,3,4] ],
                                   [ 84, [1,2,4,8,16,32,64] ],
                                   [ 94, [1,2,4,8,16,32,64] ],
                                   [ 97, [1,2,4,8,16,32,64] ],
                                   [ 127, [1,2,4,8,16,32,64] ]
                                 ],
                         checker: function (assert, input, expected, received, message) {
                             var n = input[0];
                             var ns = input[1];

                             if ( expected === null ) {
                                 assert.strictEqual( received, null, "Must be null" );
                             }
                             else {
                                 assert.strictEqual( received.sum(), n, "Sum must be correct" );
                                 assert.ok( received.isSubsetOf(ns), "Selection {0} must be subset of input {1}".format(received, ns) );
                             }
                         }
                       }
           };
})();

var student = this;



for ( var testFunctionName in tests ) {
    (function () { // New scope is necessary, since tests are not ran immediately
        var functionName = testFunctionName;
        QUnit.module(functionName);

        // Check if student implemented test
        QUnit.test( "Checking for existence of {0}".format(functionName), function (assert) {
            // (Cannot use local "tested" here because execution is postponed and "tested" might be assigned to later, making this test succeed undeservedly)
            assert.ok( student[functionName] !== undefined, "Function {0} does not exist".format(functionName) );
        } );

        // Get function to be tested
        var tested = student[functionName];

        // Use dummy implementation if necessary
        if ( forceShow ) {
            tested = tested || function() { };
        }

        // Only go further if student implemented test
        if ( tested !== undefined ) {
            // Get test data
            var testData = tests[functionName];

            // Get reference implementation
            var solution = testData.referenceImplementation;

            // Get specialized checker
            var checker = testData.checker ? testData.checker : deepEqualChecker;

            // For each test case
            _.each(testData.inputs, function (input) {
                // Get the student result
                var result = tested.apply( null, input );

                // Get the reference implementation's result
                var expectedResult = solution.apply( null, input );

                // Check for correctness using the checker
                QUnit.test( "Input: {0}, Expected: {1}".format(input, expectedResult), function (assert) {
                    checker( assert, input, result, expectedResult, "Got {0}".format(result) );
                } );
            } );
        }
    } )();
}
