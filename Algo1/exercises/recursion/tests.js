defineTests(function (test) {
    test(ReferenceImplementations.isOdd, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(5);
        builder.addInput(100);
        builder.addInput(101);
        builder.addInput(-5);
        builder.addInput(-6);
    });

    test(ReferenceImplementations.factorial, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(5);
    });

    test(ReferenceImplementations.sum, function (builder) {
        builder.addInput( [] );
        builder.addInput( [0] );
        builder.addInput( [1] );
        builder.addInput( [1,2] );
        builder.addInput( [1,2,3] );
        builder.addInput( [1,2,3,4,5,6,7,8,9,10] );
    });

    test(ReferenceImplementations.product, function (builder) {
        builder.addInput( [] );
        builder.addInput( [0] );
        builder.addInput( [1] );
        builder.addInput( [1,2] );
        builder.addInput( [1,2,3] );
        builder.addInput( [1,2,3,4,5,6,7,8,9,10] );
        builder.addInput( [1,2,3,4,0] );
    });

    test(ReferenceImplementations.countZeros, function (builder) {
        builder.addInput( [] );
        builder.addInput( [0] );
        builder.addInput( [1] );
        builder.addInput( [0,0] );
        builder.addInput( [1,1] );
        builder.addInput( [1,0,1] );
        builder.addInput( [0,1,0] );
        builder.addInput( [1,0,0] );
        builder.addInput( [2,3,4] );
    });

    test(ReferenceImplementations.removeZeros, function (builder) {
        builder.addInput( [] );
        builder.addInput( [0] );
        builder.addInput( [1] );
        builder.addInput( [0,0] );
        builder.addInput( [1,1] );
        builder.addInput( [1,0,1] );
        builder.addInput( [0,1,0] );
        builder.addInput( [1,0,0] );
        builder.addInput( [2,3,4] );
    });

    test(ReferenceImplementations.firstIndexOf, function (builder) {
        builder.addInput( 1, [] );
        builder.addInput( 1, [1] );
        builder.addInput( 1, [2] );
        builder.addInput( 2, [2] );
        builder.addInput( 2, [1,2,3] );
        builder.addInput( 3, [1,2,3] );
        builder.addInput( 4, [1,2,3] );
    });

    test(ReferenceImplementations.removeAt, function (builder) {
        builder.addInput([0], 0);
        builder.addInput([1], 0);
        builder.addInput([], 0);
        builder.addInput([1,2,3], 0);
        builder.addInput([1,2,3], 1);
        builder.addInput([1,2,3], 2);
        builder.addInput([1,2,3], 3);
    });

    test(ReferenceImplementations.isSubsetOf, function (builder) {
        builder.addInput( [], [] );
        builder.addInput( [], [1] );
        builder.addInput( [1], [1] );
        builder.addInput( [1,1], [1] );
        builder.addInput( [1], [1, 1] );
        builder.addInput( [1], [2] );
        builder.addInput( [1], [1,2] );
        builder.addInput( [1], [2,1] );
        builder.addInput( [1,2], [1,2] );
        builder.addInput( [1,2], [2,1] );
        builder.addInput( [1,2,3], [1,2,3] );
        builder.addInput( [1,2,3], [1] );
        builder.addInput( [1,2,3], [1,1,2] );
        builder.addInput( [1,2,3], [3,2,1] );
        builder.addInput( [1,2,3], [2,3,1] );
        builder.addInput( [1,2,3], [1,1,2,2,3,3] );
    });

    test(ReferenceImplementations.duplicateEachItem, function (builder) {
        builder.addInput( [] );
        builder.addInput( [0] );
        builder.addInput( [1] );
        builder.addInput( [1,2] );
        builder.addInput( [1,2,3] );
        builder.addInput( [1,1,2,2] );
    });

    test(ReferenceImplementations.range, function (builder) {
        builder.addInput(1,1);
        builder.addInput(1,2);
        builder.addInput(1,3);
        builder.addInput(2,2);
        builder.addInput(2,4);
        builder.addInput(1,10);
    });

    test(ReferenceImplementations.subarrays, function (builder) {
        builder.addInput( [] );
        builder.addInput( [1] );
        builder.addInput( [1,2] );
        builder.addInput( [1,2,3] );

        builder.setValidator(validators.io( equality.deep, equality.permutation(equality.deep) ));
    });

    test(ReferenceImplementations.permutations, function (builder) {
        builder.addInput( [] );
        builder.addInput( [1] );
        builder.addInput( [1,2] );
        builder.addInput( [1,2,3] );
        builder.addInput( [1,2,3,4] );

        builder.setValidator(validators.io( equality.deep, equality.permutation(equality.deep) ));
    });

    test(ReferenceImplementations.knapsack, function (builder) {
        builder.addInput( 0, [] );
        builder.addInput( 0, [1] );
        builder.addInput( 1, [1] );
        builder.addInput( 2, [1,1] );
        builder.addInput( 2, [1,2] );
        builder.addInput( 2, [1] );
        builder.addInput( 7, [1,2,3,4] );
        builder.addInput( 84, [1,2,4,8,16,32,64] );
        builder.addInput( 94, [1,2,4,8,16,32,64] );
        builder.addInput( 97, [1,2,4,8,16,32,64] );
        builder.addInput( 127, [1,2,4,8,16,32,64] );
        builder.addInput( 128, [1,2,4,8,16,32,64] );

        builder.setValidator( function (input, expected, received) {
            var expectedResult = expected.returnValue;
            var receivedResult = received.returnValue;
            
            if ( expectedResult === null )
            {
                return receivedResult === null;
            }
            else if ( receivedResult === null )
            {
                return false;
            }
            else
            {
                var n = input[0];
                var ns = input[1];                                 
                
                return receivedResult.sum() === n && receivedResult.isSubsetOf(ns);
            }
        } );
    });

    test(ReferenceImplementations.vowelCount, function (builder) {
        builder.addInput( "" );
        builder.addInput( "a" );
        builder.addInput( "b" );
        builder.addInput( "ab" );
        builder.addInput( "aeiou" );
        builder.addInput( "aaa" );
        builder.addInput( "abcdefghijklmnopqrstuvwxyz" );
    });

    test(ReferenceImplementations.maskVowels, function (builder) {
        builder.addInput( "" );
        builder.addInput( "a" );
        builder.addInput( "b" );
        builder.addInput( "ab" );
        builder.addInput( "aeiou" );
        builder.addInput( "aaa" );
        builder.addInput( "abcdefghijklmnopqrstuvwxyz" );
    });

    test(ReferenceImplementations.rle, function (builder) {
        builder.addInput( "" );
        builder.addInput( "a" );
        builder.addInput( "aa" );
        builder.addInput( "aaa" );
        builder.addInput( "aaaaaaaaaaaaa" );
        builder.addInput( "aabbcc" );
        builder.addInput( "aaaaaaabbbbbbbbcccccc" );
        builder.addInput( "aaaaaaabbbbbbbbaaaaaaaaaaaa" );
    });

    test(ReferenceImplementations.compress, function (builder) {
        builder.addInput( "" );
        builder.addInput( "a" );
        builder.addInput( "aa" );
        builder.addInput( "aaa" );
        builder.addInput( "aaaaaaaaaaaaa" );
        builder.addInput( "aaaaaaaaaaaaaaaaaaaa" );
        builder.addInput( "aabbcc" );
        builder.addInput( "aaaaaaabbbbbbbbcccccc" );
        builder.addInput( "aaaaaaabbbbbbbbaaaaaaaaaaaa" );
    });

    test(ReferenceImplementations.repeat, function (builder) {
        builder.addInput( "a", 0 );
        builder.addInput( "a", 1 );
        builder.addInput( "a", 2 );
        builder.addInput( "a", 10 );
        builder.addInput( "b", 5 );
    });

    test(ReferenceImplementations.decompress, function (builder) {
        builder.addInput( "" );
        builder.addInput( "a1" );
        builder.addInput( "a2" );
        builder.addInput( "a9" );
        builder.addInput( "a9a9a2" );
        builder.addInput( "a2b3c6" );
    });
});
