defineTests(function (test) {

    test(Solutions.randomInteger, function (builder) {
        builder.addInput( 0, 5 );
        builder.addInput( 0, 10 );
        builder.addInput( 1, 10 );
        builder.addInput( 5, 10 );
    });

    test(Solutions.throwDie, function (builder) {
        builder.addInput();
        builder.addInput();
        builder.addInput();
    });

    test(Solutions.sumDice, function (builder) {
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(5);
    });

    test(Solutions.countSumDice, function (builder) {
        builder.addInput(1, 1, 1);
        builder.addInput(1, 1, 3);
        builder.addInput(2, 1, 7);
        builder.addInput(3, 10, 8);
        builder.addInput(3, 10, 8);
        builder.addInput(3, 50, 8);
        builder.addInput(5, 1000, 20);
    });

    test(Solutions.mostFrequentSum, function (builder) {
       builder.addInput(1); 
       builder.addInput(2); 
       builder.addInput(3);
       builder.addInput(4); 
       builder.addInput(5); 
    });

    test(Solutions.product, function (builder) {
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

    test(Solutions.quotient, function (builder) {
        builder.addInput(0, 1);
        builder.addInput(1, 1);
        builder.addInput(5, 1);
        builder.addInput(10, 2);
        builder.addInput(12, 2);
        builder.addInput(12, 3);
        builder.addInput(12, 4);
        builder.addInput(12, 5);
        builder.addInput(30, 7);
    });

    test(Solutions.modulo, function (builder) {
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
    });
});
