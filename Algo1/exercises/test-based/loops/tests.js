defineTests(function (test) {
    test(ReferenceImplementations.rangeSum, function (builder) {
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

    test(ReferenceImplementations.factorial, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(2);
        builder.addInput(3);
        builder.addInput(4);
        builder.addInput(5);
        builder.addInput(6);
    });

    test(ReferenceImplementations.gcd, function (builder) {
        builder.addInput(1, 5);
        builder.addInput(2, 2);
        builder.addInput(2, 4);
        builder.addInput(15, 20);
        builder.addInput(25, 50);
        builder.addInput(50, 25);
        builder.addInput(13 * 3, 13 * 5);
    });

    test(ReferenceImplementations.lcm, function (builder) {
        builder.addInput(1, 5);
        builder.addInput(2, 2);
        builder.addInput(2, 4);
        builder.addInput(15, 20);
        builder.addInput(25, 50);
        builder.addInput(50, 25);
        builder.addInput(13 * 3, 13 * 5);
    });

    test(ReferenceImplementations.countTrailingZeros, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(10);
        builder.addInput(1000);
        builder.addInput(203);
        builder.addInput(708060);
        builder.addInput(70800);
        builder.addInput(-70800);
    });

    test(ReferenceImplementations.countZeros, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(10);
        builder.addInput(1000);
        builder.addInput(203);
        builder.addInput(708060);
        builder.addInput(70800);
        builder.addInput(-70800);
    });

    test(ReferenceImplementations.countDigits, function (builder) {
        builder.addInput(0);
        builder.addInput(1);
        builder.addInput(12);
        builder.addInput(123);
        builder.addInput(1234);
        builder.addInput(1000);
        builder.addInput(-1);
        builder.addInput(-135);
    });

    test(ReferenceImplementations.isPrime, function (builder) {
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

    test(ReferenceImplementations.sumDigits, function (builder) {
        builder.addInput(1);
        builder.addInput(11);
        builder.addInput(111);
        builder.addInput(123);
        builder.addInput(0);
        builder.addInput(12345);
        builder.addInput(54321);
    });

    test(ReferenceImplementations.greatestDigitProduct, function (builder) {
        builder.addInput(10);
        builder.addInput(20);
        builder.addInput(304);
        builder.addInput(23045);
        builder.addInput(10203);
        builder.addInput(23033024);
        builder.addInput(23033025);
        builder.addInput(93033025);
        builder.addInput(5);
        builder.addInput(-1);
        builder.addInput(-1000);
    });

    test(ReferenceImplementations.greatestSumOfDigitTriples, function (builder) {
        builder.addInput(1000);
        builder.addInput(10203);
        builder.addInput(12345);
        builder.addInput(999111111);
        builder.addInput(111111999);
        builder.addInput(111999111);
        builder.addInput(16782469);
        builder.addInput(5);
        builder.addInput(53);
        builder.addInput(-1);
        builder.addInput(-1000);
    });
});
