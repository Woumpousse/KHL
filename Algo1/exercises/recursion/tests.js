/*
  If false, no test cases are shown for X if no function for X has been defined.
*/
var forceShow = true;

function deepEqualChecker(assert, expected, received, message) {
    assert.deepEqual(expected, received, message);
}

function permutationChecker(assert, expected, received, message) {
    assert.ok( expected !== undefined && expected.isPermutationOf(received), message );
}

var tests = ( function() {
    function sum(xs) {
         if ( xs.length === 0 ) {
            return 0;
        }
        else {
            return xs[0] + sum( xs.slice(1) );
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

    function range(a, b) {
        if ( a > b ) {
            return [];
        }
        else {
            return [a].concat( range(a+1, b) );
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

    return { sum: { referenceImplementation: sum,
                    inputs: [ [ [] ],
                              [ [0] ],
                              [ [1] ],
                              [ [1,2] ],
                              [ [1,2,3] ],
                              [ [1,2,3,4,5,6,7,8,9,10] ]
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
                           }
           };
})();

var student = this;



for ( functionName in tests ) {
    (function () { // New scope is necessary, since tests are not ran immediately
        QUnit.module(functionName);

        // Check if student implemented test
        QUnit.test( "Checking for existence of {0}".format(functionName), function (assert) {
            assert.ok( student[functionName] !== undefined ); // (Cannot use local "tested" here because execution is postponed and "tested" might be assigned to later, making this test succeed undeservedly)
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
                    checker( assert, result, expectedResult, "Got {0}".format(result) );
                } );
            } );
        }
    } )();
}
