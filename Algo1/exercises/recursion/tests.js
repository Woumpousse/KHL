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

    test(ReferenceImplementations.highestDivisor, function (builder) {
        builder.addInput( 2, 2 );
        builder.addInput( 2, 4 );
        builder.addInput( 2, 5 );
        builder.addInput( 10, 10 );
        builder.addInput( 9, 10 );
        builder.addInput( 36, 37 );
    });

    test(ReferenceImplementations.isPrime, function (builder) {
        builder.addInput( 1 );
        builder.addInput( 2 );
        builder.addInput( 3 );
        builder.addInput( 4 );
        builder.addInput( 5 );
        builder.addInput( 6 );
        builder.addInput( 7 );
        builder.addInput( 8 );
        builder.addInput( 9 );
        builder.addInput( 10 );
        builder.addInput( 11 );
    });
    
    test(ReferenceImplementations.sumPrimes, function (builder) {
        builder.addInput( 1 );
        builder.addInput( 2 );
        builder.addInput( 3 );
        builder.addInput( 4 );
        builder.addInput( 5 );
        builder.addInput( 6 );
        builder.addInput( 7 );
        builder.addInput( 8 );
        builder.addInput( 9 );
        builder.addInput( 10 );
        builder.addInput( 11 );
    });
});
