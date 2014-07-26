function deepEqualChecker(assert, expected, received, message) {
    assert.deepEqual(expected, received, message);
}

function permutationChecker(assert, expected, received, message) {
    assert.ok( expected !== undefined && expected.isPermutationOf(received), message );
}

var solutions = ( function() {
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
            return solutions.removeZeros( xs.slice(1) );
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
    }

    function permutations(xs) {
        if ( xs.length === 0 ) {
            return [ [] ];
        }
        else {
            var result = [];

            for ( var i = 0; i != xs.length; ++i ) {
                var picked = xs[i];
                var rest = xs.slice(0, i).concat( xs.slice(i+1) );

                var restPermutations = permutations( rest );

                for ( var j = 0; j != restPermutations.length; ++j ) {
                    result.push( [picked].concat( restPermutations[j] ) );
                }
            }

            return result;
        }
    }

    return { sum: sum,
             countZeros: countZeros,
             removeZeros: removeZeros,
             range: range,
             permutations: permutations
           };
})();

// var student = solutions;
var student = this;


tests = { sum: { inputs: [ [ [] ],
                           [ [0] ],
                           [ [1] ],
                           [ [1,2] ],
                           [ [1,2,3] ],
                           [ [1,2,3,4,5,6,7,8,9,10] ]
                         ]
               },
          countZeros: { inputs: [ [ [] ],
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
          removeZeros: { inputs: [ [ [] ],
                                   [ [0] ],
                                   [ [1] ],
                                   [ [0,0] ],
                                   [ [1,1] ],
                                   [ [1,0,1] ],
                                   [ [0,1,0] ],
                                   [ [1,0,0] ],
                                   [ [2,3,4] ]
                                 ],
                       },
          range: { inputs: [ [1,1],
                             [1,2],
                             [1,3],
                             [2,2],
                             [2,4],
                             [1,10] ]
                 },
          permutations: { inputs: [ [ [] ],
                                    [ [1] ],
                                    [ [1,2] ],
                                    [ [1,2,3] ],
                                    [ [1,2,3,4] ]
                                  ],
                          checker: permutationChecker
                        },
        };

for ( functionName in tests ) {
    (function () {
        QUnit.module(functionName);

        var tested = student[functionName];

        QUnit.test( "Checking for existence of {0}".format(functionName), function (assert) {
            assert.ok( tested !== undefined );
        } );

        if ( tested !== undefined ) {
            var solution = solutions[functionName];
            var testData = tests[functionName];
            var checker = testData.checker ? testData.checker : deepEqualChecker;

            _.each(testData.inputs, function (input) {
                var result = tested.apply( null, input );
                var expectedResult = solution.apply( null, input );

                QUnit.test( "Input: {0}, Expected: {1}".format(input, expectedResult), function (assert) {
                    checker( assert, result, expectedResult, "Got {0}".format(result) );
                } );
            } );
        }
    } )();
}
