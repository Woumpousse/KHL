defineTests(function (test) {

    test(ReferenceImplementations.randomInteger, function (builder) {
        builder.addInput( 0, 5 );
        builder.addInput( 0, 10 );
        builder.addInput( 1, 10 );
        builder.addInput( 5, 10 );
    });

    test(ReferenceImplementations.throwDie, function (builder) {
        builder.addInput();
        builder.addInput();
        builder.addInput();
    });

    test(ReferenceImplementations.sumDice, function (builder) {
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(5);
    });

    test(ReferenceImplementations.countSumDice, function (builder) {
        builder.addInput(1, 1, 1);
        builder.addInput(1, 1, 3);
        builder.addInput(2, 1, 7);
        builder.addInput(3, 10, 8);
        builder.addInput(3, 10, 8);
        builder.addInput(3, 50, 8);
        builder.addInput(5, 1000, 20);
    });

    test(ReferenceImplementations.mostFrequentSum, function (builder) {
       builder.addInput(1); 
       builder.addInput(2); 
       builder.addInput(3);
       builder.addInput(4); 
       builder.addInput(5); 
    });

    test(ReferenceImplementations.product, function (builder) {
       builder.addInput(0, 0); 
       builder.addInput(0, 5); 
       builder.addInput(5, 0);
       builder.addInput(1, 1); 
       builder.addInput(1, 5); 
       builder.addInput(4, 1); 
       builder.addInput(2, 3); 
       builder.addInput(9, 11); 
       builder.addInput(-1, 1); 
       builder.addInput(1, -1);
       builder.addInput(-1, -1);
       builder.addInput(-5, 6);
       builder.addInput(95, -6);
       builder.addInput(-101, -36);
    });

    test(ReferenceImplementations.quotient, function (builder) {
        builder.addInput(0, 1);
        builder.addInput(1, 1);
        builder.addInput(5, 1);
        builder.addInput(10, 2);
        builder.addInput(12, 2);
        builder.addInput(12, 3);
        builder.addInput(12, 4);
        builder.addInput(12, 5);
        builder.addInput(30, 7);
        builder.addInput(-3, 2);
        builder.addInput(6, -7);
        builder.addInput(2, 0);
        builder.addInput(-3, -2);
    });

    test(ReferenceImplementations.modulo, function (builder) {
        builder.addInput(0, 1);
        builder.addInput(1, 1);
        builder.addInput(2, 1);
        builder.addInput(0, 2);
        builder.addInput(1, 2);
        builder.addInput(2, 2);
        builder.addInput(3, 2);
        builder.addInput(4, 2);
        builder.addInput(5, 2);
        builder.addInput(10, 3);
        builder.addInput(100, 31);
        builder.addInput(101, 31);
        builder.addInput(102, 31);
        builder.addInput(4, -21);
        builder.addInput(-12, 7);
        builder.addInput(-44, -3);
        builder.addInput(111, 0);
    });

    test(ReferenceImplementations.pow, function (builder) {
        builder.addInput(1, 0);
        builder.addInput(1, 1);
        builder.addInput(1, 2);
        builder.addInput(2, 2);
        builder.addInput(2, 5);
        builder.addInput(0, 5);
        builder.addInput(0, 0);
        builder.addInput(3, 3);
        builder.addInput(-3, 3);
        builder.addInput(-3, -4);
        builder.addInput(1, -2);
    });

    test(ReferenceImplementations.calc, function (builder) {
        builder.addInput("+", 5, 3);
        builder.addInput("-", 8, 2);
        builder.addInput("*", 6, 9);
        builder.addInput("/", 9, 3);
        builder.addInput("/", 9, 2);
        builder.addInput("/", 33, 0);
        builder.addInput("%", 10, 6);
        builder.addInput("%", 10, 5);
        builder.addInput("%", 15, 0);
        builder.addInput("^", 13, 4);
        builder.addInput("^", 13, -4);
        builder.addInput("&", 13, -4);
    });
});
