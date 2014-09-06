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
});
