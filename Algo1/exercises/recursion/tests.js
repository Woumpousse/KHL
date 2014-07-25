var solutions = {
    sum: function (xs) {
         if ( xs.length === 0 ) {
            return 0;
        }
        else {
            return xs[0] + solutions.sum( xs.slice(1) );
        }
    },

    countZeros: function (xs) {
        if ( xs.length === 0 ) {
            return 0;
        }
        else if ( xs[0] === 0 ) {
            return 1 + solutions.countZeros( xs.slice(1) );
        }
        else {
            return solutions.countZeros( xs.slice(1) );
        }
    },

    removeZeros: function (xs) {
        if ( xs.length === 0 ) {
            return [];
        }
        else if ( xs[0] === 0 ) {
            return solutions.removeZeros( xs.slice(1) );
        }
        else {
            return [ xs[0] ].concat( solutions.removeZeros( xs.slice(1) ) );
        }
    }
};

var student = solutions;
// var student = this;


tests = { sum: [ [ [] ],
                 [ [0] ],
                 [ [1] ],
                 [ [1,2] ],
                 [ [1,2,3] ],
                 [ [1,2,3,4,5,6,7,8,9,10] ]
               ],
          countZeros: [ [ [] ],
                        [ [0] ],
                        [ [1] ],
                        [ [0,0] ],
                        [ [1,1] ],
                        [ [1,0,1] ],
                        [ [0,1,0] ],
                        [ [1,0,0] ],
                        [ [2,3,4] ]
                      ],
          removeZeros: [ [ [] ],
                         [ [0] ],
                         [ [1] ],
                         [ [0,0] ],
                         [ [1,1] ],
                         [ [1,0,1] ],
                         [ [0,1,0] ],
                         [ [1,0,0] ],
                         [ [2,3,4] ]
                       ]
        };


for ( functionName in tests ) {
    QUnit.module(functionName);

    var tested = student[functionName];
    var solution = solutions[functionName];
    var testData = tests[functionName];

    testData.forEach( function (input) {
        var result = tested.apply( null, input );
        var expectedResult = solution.apply( null, input );

        QUnit.test( "Input: {0}, Expected: {1}".format(input, expectedResult), function(assert) {
            assert.deepEqual( result, expectedResult, "Got answer {0}".format(result) );
        } );
    } );
}
