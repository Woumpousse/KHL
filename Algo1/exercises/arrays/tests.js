defineTests(function (test) {
    test(ReferenceImplementations.contains, function (builder) {
        builder.addInput([], 1);
        builder.addInput([1], 1);
        builder.addInput([0], 1);
        builder.addInput([1, 2, 3], 1);
        builder.addInput([1, 2, 3], 2);
        builder.addInput([1, 2, 3], 3);
    });

    test(ReferenceImplementations.sum, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 1, 1]);
        builder.addInput([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
    });

    test(ReferenceImplementations.product, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        builder.addInput([1, 2, 3, 4, 0]);
    });

    test(ReferenceImplementations.average, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);
        builder.addInput([1, 2, 3, 4, 0]);
    });

    test(ReferenceImplementations.incrementEachItem, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([0, 0, 0]);
        builder.addInput([1, 2, 3]);
    });

    test(ReferenceImplementations.countZeros, function (builder) {
        builder.addInput([]);
        builder.addInput([0]);
        builder.addInput([1]);
        builder.addInput([0, 0]);
        builder.addInput([1, 1]);
        builder.addInput([0, 1, 0]);
        builder.addInput([1, 0, 0]);
        builder.addInput([2, 3, 4]);
    });

    test(ReferenceImplementations.firstIndexOf, function (builder) {
        builder.addInput(1, []);
        builder.addInput(1, [1]);
        builder.addInput(1, [2]);
        builder.addInput(2, [2]);
        builder.addInput(2, [1, 2, 3]);
        builder.addInput(3, [1, 2, 3]);
        builder.addInput(4, [1, 2, 3]);
        builder.addInput(1, [0, 1, 0, 1, 0, 1, 0]);
    });

    test(ReferenceImplementations.lastIndexOf, function (builder) {
        builder.addInput(1, []);
        builder.addInput(1, [1]);
        builder.addInput(1, [2]);
        builder.addInput(2, [2]);
        builder.addInput(2, [1, 2, 3]);
        builder.addInput(3, [1, 2, 3]);
        builder.addInput(4, [1, 2, 3]);
        builder.addInput(1, [0, 1, 0, 1, 0, 1, 0]);
    });

    test(ReferenceImplementations.range, function (builder) {
        builder.addInput(1, 1);
        builder.addInput(1, 2);
        builder.addInput(1, 3);
        builder.addInput(2, 2);
        builder.addInput(2, 4);
        builder.addInput(1, 10);
        builder.addInput(5, 1);
    });

    test(ReferenceImplementations.reverse, function (builder) {
        builder.addInput([]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 3, 4]);
        builder.addInput([1, 2, 3, 4, 5]);
        builder.addInput([1, 1, 2, 3, 3, 4, 5, 5, 6]);
        builder.addInput([1, 3, 5, 7, 9, 8, 4, 6, 2]);
    });

    test(ReferenceImplementations.isPalindrome, function (builder) {
        builder.addInput([]);
        builder.addInput([1]);
        builder.addInput([1, 2]);
        builder.addInput([1, 2, 3]);
        builder.addInput([1, 2, 1]);
        builder.addInput([1, 2, 2]);
        builder.addInput([1, 2, 2, 1]);
    });

    test(ReferenceImplementations.minimum, function (builder) {
        builder.addInput([0]);
        builder.addInput([0, 1]);
        builder.addInput([1, 0]);
        builder.addInput([1, 2, 3, 4, 5]);
        builder.addInput([1, 3, 5, 4, 2]);
        builder.addInput([1, 3, 0, 5, 4, 2]);
    });

    test(ReferenceImplementations.maximum, function (builder) {
        builder.addInput([0]);
        builder.addInput([0, 1]);
        builder.addInput([1, 0]);
        builder.addInput([1, 2, 3, 4, 5]);
        builder.addInput([1, 3, 5, 4, 2]);
        builder.addInput([1, 3, 0, 5, 4, 2]);
    });

    test(ReferenceImplementations.isIncreasing, function (builder) {
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

    test(ReferenceImplementations.isDecreasing, function (builder) {
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

    test(ReferenceImplementations.areEqual, function (builder) {
        builder.addInput([], []);
        builder.addInput([], [1]);
        builder.addInput([1], []);
        builder.addInput([1], [1]);
        builder.addInput([1,2,3], [1,2,3]);
        builder.addInput([1,2,3], [3,2,1]);
    });

    test(ReferenceImplementations.alternates, function (builder) {
        builder.addInput([]);
        builder.addInput([1]);
        builder.addInput([1,2]);
        builder.addInput([1,2,3,4,5]);
        builder.addInput([5,4,3,2,1]);
        builder.addInput([1,2,3,4,5,6]);
        builder.addInput([6,5,4,3,2,1]);
    });

    test(ReferenceImplementations.lengthOfLongestIncreasingSubarray, function (builder) {
        builder.addInput([]);
        builder.addInput([1]);
        builder.addInput([1,2]);
        builder.addInput([1,2,3,4,5]);
        builder.addInput([1,2,3,1,2,3,4,1,2,3]);
        builder.addInput([1,1,1,1,1]);
        builder.addInput([1,2,2,3,3,3]);
        builder.addInput([5,4,3,2,1]);
        builder.addInput([1,2,1,2,1,2]);
        builder.addInput([1,2,1,2,3,1,2,3,4]);
    });
});
