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
});
