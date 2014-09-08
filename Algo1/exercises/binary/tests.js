defineTests(function (test) {
    test(ReferenceImplementations.isBinary, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(-1);
        builder.addInput(1001101);
        builder.addInput(100110501);
    });

    test(ReferenceImplementations.binaryToDecimal, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(10);
        builder.addInput(101);
        builder.addInput(111);
        builder.addInput(1000);
        builder.addInput(10101011);
        builder.addInput(2);
        builder.addInput(-101);
    });

    test(ReferenceImplementations.decimalToBinary, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(-1);
        builder.addInput(10);
        builder.addInput(8);
        builder.addInput(16);
        builder.addInput(31);
        builder.addInput(5454);
    });

    test(ReferenceImplementations.binaryAdd, function (builder) {
        builder.addInput(0, 0);
        builder.addInput(0, 1);
        builder.addInput(1, 0);
        builder.addInput(10, 1);
        builder.addInput(101010, 10101);
        builder.addInput(1, 1);
        builder.addInput(11111, 111111);
        builder.addInput(-111, 111);
        builder.addInput(11121, 10111);
        builder.addInput(11101, 101511);
    });
});
