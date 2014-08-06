defineTests(function (test) {
    test(Solutions.rangeSum, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(0, -1);
        builder.addInput(1, 0);
        builder.addInput(0, 1);
        builder.addInput(0, 2);
        builder.addInput(0, 3);
        builder.addInput(0, 10);
        builder.addInput(5, 10);
        builder.addInput(10, 20);
    });

    test(Solutions.countTrailingZeros, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(10);
        builder.addInput(1000);
        builder.addInput(203);
        builder.addInput(708060);
        builder.addInput(70800);
        builder.addInput(-70800);
    });

    test(Solutions.countZeros, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(10);
        builder.addInput(1000);
        builder.addInput(203);
        builder.addInput(708060);
        builder.addInput(70800);
        builder.addInput(-70800);
    });

    test(Solutions.isPrime, function (builder) {
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(5);
        builder.addInput(6);
        builder.addInput(7);
        builder.addInput(8);
        builder.addInput(9);
        builder.addInput(10);
        builder.addInput(100);
        builder.addInput(101);
    });
});
