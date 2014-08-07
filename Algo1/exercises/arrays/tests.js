defineTests(function (test) {
    test(Solutions.contains, function (builder) {
        builder.addInput([], 1);
        builder.addInput([1], 1);
        builder.addInput([0], 1);
        builder.addInput([1, 2, 3], 1);
        builder.addInput([1, 2, 3], 2);
        builder.addInput([1, 2, 3], 3);
    });

    test(Solutions.sum, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 1, 1]);
        builder.addInput([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    });

    test(Solutions.product, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        builder.addInput([1, 2, 3, 4, 0]);
    });

    test(Solutions.average, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        builder.addInput([1, 2, 3, 4, 0]);
    });

    test(Solutions.incrementEachItem, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([0, 0, 0]);
        builder.addInput([1, 2, 3]);
    });

    test(Solutions.countZeros, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([0, 0]);
        builder.addInput([1, 1]);
        builder.addInput([0, 1, 0]);
        builder.addInput([1, 0, 0]);
        builder.addInput([2, 3, 4]);
    });

    test(Solutions.firstIndexOf, function (builder) {
        builder.addInput(1, []);
        builder.addInput(1, [1]);
        builder.addInput(1, [2]);
        builder.addInput(2, [2]);
        builder.addInput(2, [1, 2, 3]);
        builder.addInput(3, [1, 2, 3]);
        builder.addInput(4, [1, 2, 3]);
        builder.addInput(1, [0, 1, 0, 1, 0, 1, 0]);
    });

    test(Solutions.lastIndexOf, function (builder) {
        builder.addInput(1, []);
        builder.addInput(1, [1]);
        builder.addInput(1, [2]);
        builder.addInput(2, [2]);
        builder.addInput(2, [1, 2, 3]);
        builder.addInput(3, [1, 2, 3]);
        builder.addInput(4, [1, 2, 3]);
        builder.addInput(1, [0, 1, 0, 1, 0, 1, 0]);
    });

    test(Solutions.range, function (builder) {
        builder.addInput(1, 1);
        builder.addInput(1, 2);
        builder.addInput(1, 3);
        builder.addInput(2, 2);
        builder.addInput(2, 4);
        builder.addInput(1, 10);
    });

    test(Solutions.reverse, function (builder) {
        builder.addInput([]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 3, 4]);
        builder.addInput([1, 2, 3, 4, 5]);
        builder.addInput([1, 1, 2, 3, 3, 4, 5, 5, 6]);
        builder.addInput([1, 3, 5, 7, 9, 8, 4, 6, 2]);
    });

    test(Solutions.isPalindrome, function (builder) {
        builder.addInput([]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 1]);
        builder.addInput([1, 2, 2]);
        builder.addInput([1, 2, 2, 1]);
    });

    test(Solutions.minimum, function (builder) {
        builder.addInput([0]);
        builder.addInput([0, 1]);
        builder.addInput([1, 0]);
        builder.addInput([1, 2, 3, 4, 5]);
        builder.addInput([1, 3, 5, 4, 2]);
        builder.addInput([1, 3, 0, 5, 4, 2]);
    });

    test(Solutions.maximum, function (builder) {
        builder.addInput([0]);
        builder.addInput([0, 1]);
        builder.addInput([1, 0]);
        builder.addInput([1, 2, 3, 4, 5]);
        builder.addInput([1, 3, 5, 4, 2]);
        builder.addInput([1, 3, 0, 5, 4, 2]);
    });

    test(Solutions.isIncreasing, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([0, 1]);
        builder.addInput([0, 1, 2]);
        builder.addInput([1, 0]);
        builder.addInput([0, 1, 2, 3, 4, 5, 0]);
        builder.addInput([5, 4, 3, 2, 1]);
        builder.addInput([1, 1, 1]);
        builder.addInput([1, 1, 2, 3, 3]);
    });

    test(Solutions.isDecreasing, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([0, 1]);
        builder.addInput([0, 1, 2]);
        builder.addInput([1, 0]);
        builder.addInput([0, 1, 2, 3, 4, 5, 0]);
        builder.addInput([5, 4, 3, 2, 1]);
        builder.addInput([1, 1, 1]);
        builder.addInput([1, 1, 2, 3, 3]);
    });

    test(Solutions.areEqual, function (builder) {
        builder.addInput([], []);
        builder.addInput([], [1]);
        builder.addInput([1], []);
        builder.addInput([1], [1]);
        builder.addInput([1,2,3], [1,2,3]);
        builder.addInput([1,2,3], [3,2,1]);
    });

    test(Solutions.alternates, function (builder) {
        builder.addInput([]);
        builder.addInput([1]);
        builder.addInput([1,2]);
        builder.addInput([1,2,3,4,5]);
        builder.addInput([5,4,3,2,1]);
        builder.addInput([1,2,3,4,5,6]);
        builder.addInput([6,5,4,3,2,1]);
    });
});
