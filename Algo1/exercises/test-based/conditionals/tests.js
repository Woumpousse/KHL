defineTests(function (test) {
    test(ReferenceImplementations.average, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(0, 2);
        builder.addInput(0, 10);
        builder.addInput(4, 8);
        builder.addInput(1, 3);
    });

    test(ReferenceImplementations.isOdd, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(100);
        builder.addInput(101);
        builder.addInput(100000);
        builder.addInput(100001);
    });

    test(ReferenceImplementations.isEven, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(100);
        builder.addInput(101);
        builder.addInput(100000);
        builder.addInput(100001);
    });

    test(ReferenceImplementations.endsInZero, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(770);
        builder.addInput(775);
        builder.addInput(243000);
        builder.addInput(-5);
        builder.addInput(-10);
        builder.addInput(-150);
    });


    test(ReferenceImplementations.endsInThreeZeros, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(770);
        builder.addInput(7700);
        builder.addInput(77000);
        builder.addInput(1000);
        builder.addInput(-1000);
        builder.addInput(-1001);
    });


    test(ReferenceImplementations.minimumOfTwo, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(1, 0);
        builder.addInput(0, 1);
        builder.addInput(4, 3);
        builder.addInput(5, 7);
    });

    test(ReferenceImplementations.abs, function (builder) {
        builder.addInput(0);
        builder.addInput(-1);
        builder.addInput(1);
        builder.addInput(-6);
        builder.addInput(8);
    });

    test(ReferenceImplementations.maximumOfThree, function (builder) {
        builder.addInput(0, 0, 0);
        builder.addInput(1, 0, 0);
        builder.addInput(0, 1, 0);
        builder.addInput(0, 0, 1);
        builder.addInput(1, 2, 3);
        builder.addInput(1, 3, 2);
        builder.addInput(2, 1, 3);
        builder.addInput(2, 3, 1);
        builder.addInput(3, 2, 1);
        builder.addInput(3, 1, 2);
        builder.addInput(45, 80, 79);
    });

    test(ReferenceImplementations.sort, function (builder) {
        builder.addInput(1, 2, 3);
        builder.addInput(1, 3, 2);
        builder.addInput(2, 1, 3);
        builder.addInput(2, 3, 1);
        builder.addInput(3, 2, 1);
        builder.addInput(3, 1, 2);
        builder.addInput(4, 6, 5);
        builder.addInput(8, 8, 9);
        builder.addInput(9, 8, 9);
        builder.addInput(9, 9, 8);
        builder.addInput(45, 80, 79);
    });

    test(ReferenceImplementations.cost1, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(10);
    });
    
    test(ReferenceImplementations.cost2, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(1, 0);
        builder.addInput(0, 1);
        builder.addInput(1, 1);
        builder.addInput(3, 5);
    });

    test(ReferenceImplementations.cost3, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(1, 0);
        builder.addInput(0, 1);
        builder.addInput(1, 1);
        builder.addInput(3, 5);
    });

    test(ReferenceImplementations.cost4, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(1, 0);
        builder.addInput(0, 1);
        builder.addInput(1, 1);
        builder.addInput(1, 2);
        builder.addInput(2, 2);
        builder.addInput(3, 0);
        builder.addInput(0, 3);
        builder.addInput(3, 5);
    });

    test(ReferenceImplementations.cost5, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(1, 0);
        builder.addInput(0, 1);
        builder.addInput(1, 1);
        builder.addInput(1, 2);
        builder.addInput(2, 2);
        builder.addInput(3, 0);
        builder.addInput(0, 3);
        builder.addInput(3, 5);
    });
});
