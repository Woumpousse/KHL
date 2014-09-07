defineTests(function (originalTest) {
    var zigZag = ReferenceImplementations.zigZag;

    function test( func, builder )
    {
        originalTest( func, function (b) {
            var F = formatters;
            var P = predicates;

            var formatter = F.byType( [ P.isMatrix, F.matrix ],
                                      [ P.any, F.simple ] );

            b.setFormatter( formatter );

            builder( b );
        } );
    }

    gridInputs = [ zigZag(1, 1),
                   zigZag(1, 2),
                   zigZag(2, 1),
                   zigZag(2, 2),
                   zigZag(3, 1),
                   zigZag(3, 2),
                   zigZag(3, 3)
                 ];

    test(ReferenceImplementations.createGrid, function (builder) {
        builder.addInput( 1, 1, 1 );
        builder.addInput( 1, 2, 0 );
        builder.addInput( 2, 1, "a" );
        builder.addInput( 2, 2, [0] );
        builder.addInput( 10, 10, 0 );
    });

    test(ReferenceImplementations.arrayLengths, function (builder) {
        builder.addInput( [[]] );
        builder.addInput( [[1]] );
        builder.addInput( [[1],[1]] );
        builder.addInput( [[1,2],[1]] );
        builder.addInput( [[1],[1,2]] );
        builder.addInput( [[], [], []] );
        builder.addInput( [[1,2],[1,2]] );
    });

    test(ReferenceImplementations.isRectangular, function (builder) {
        builder.addInput( [[]] );
        builder.addInput( [[1]] );
        builder.addInput( [[1],[1]] );
        builder.addInput( [[1,2],[1]] );
        builder.addInput( [[1],[1,2]] );
        builder.addInput( [[], [], []] );
        builder.addInput( [[1,2],[1,2]] );
        builder.addInput( [[1,2,3],[1,2,3]] );

        builder.setFormatter( formatters.simple );
    });

    test(ReferenceImplementations.width, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });

    test(ReferenceImplementations.height, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });

    test(ReferenceImplementations.isSquare, function (builder) {
        builder.addInput( [[]] );
        builder.addInput( [[1]] );
        builder.addInput( [[1],[1]] );
        builder.addInput( [[1,2],[1]] );
        builder.addInput( [[1],[1,2]] );
        builder.addInput( [[], [], []] );
        builder.addInput( [[1,2],[1,2]] );

        builder.setFormatter( formatters.simple );
    });

    test(ReferenceImplementations.zigZag, function (builder) {
        builder.addInput(1, 1);
        builder.addInput(1, 2);
        builder.addInput(1, 3);
        builder.addInput(2, 1);
        builder.addInput(3, 1);
        builder.addInput(2, 2);
        builder.addInput(2, 3);
        builder.addInput(3, 2);
        builder.addInput(3, 3);
    });
    
    test(ReferenceImplementations.getRow, function (builder) {
        builder.addInput( zigZag(1, 1), 0 );
        builder.addInput( zigZag(1, 2), 0 );
        builder.addInput( zigZag(1, 2), 1 );
        builder.addInput( zigZag(2, 1), 0 );
        builder.addInput( zigZag(2, 2), 0 );
        builder.addInput( zigZag(2, 2), 1 );
        builder.addInput( zigZag(5, 5), 0 );
        builder.addInput( zigZag(5, 5), 1 );
        builder.addInput( zigZag(5, 5), 2 );
        builder.addInput( zigZag(5, 5), 3 );
        builder.addInput( zigZag(5, 5), 4);
    });

    test(ReferenceImplementations.getColumn, function (builder) {
        builder.addInput( zigZag(1, 1), 0 );
        builder.addInput( zigZag(2, 2), 0 );
        builder.addInput( zigZag(2, 1), 0 );
        builder.addInput( zigZag(2, 2), 0 );
        builder.addInput( zigZag(2, 2), 1 );
        builder.addInput( zigZag(5, 5), 0 );
        builder.addInput( zigZag(5, 5), 1 );
        builder.addInput( zigZag(5, 5), 2 );
        builder.addInput( zigZag(5, 5), 3 );
        builder.addInput( zigZag(5, 5), 4 );
    });

    test(ReferenceImplementations.rowSums, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });

    test(ReferenceImplementations.columnSums, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });

    test(ReferenceImplementations.matrixAddition, function (builder) {
        builder.addInput( [[1]], [[1]] );
        builder.addInput( [[1]], [[2]] );
        builder.addInput( [[1,2]], [[1,2]] );
        builder.addInput( [[1,2,3]], [[3,2,1]] );
        builder.addInput( [[1,2,3],[4,5,6]], [[3,2,1],[6,5,4]] );
        builder.addInput( [[1,2,3],[4,5,6],[7,8,9]], [[3,2,1],[6,5,4],[9,8,7]] );
        builder.addInput( [[1,0,2],[4,2,0],[1,4,7]], [[7,5,3],[1,5,9],[0,1,3]] );
    });

    test(ReferenceImplementations.matrixMultiplication, function (builder) {
        builder.addInput( [[1]], [[1]] );
        builder.addInput( [[1]], [[2]] );
        builder.addInput( [[1],[1]], [[1,1]] );
        builder.addInput( [[0],[1]], [[1,1]] );
        builder.addInput( [[0],[1]], [[1,1]] );
        builder.addInput( [[1,1],[1,1]], [[1,1]] );
        builder.addInput( [[1,1],[1,1]], [[0,1]] );
        builder.addInput( [[1,2],[3,4]], [[2,3]] );
        builder.addInput( [[1,2,7],[3,4,4]], [[2,3]] );
        builder.addInput( [[1,2,7],[3,4,4],[8,7,6]], [[2,3,1]] );
        builder.addInput( [[1,2,7],[3,4,4],[8,7,6]], [[2,3,1],[0,0,0],[2,5,6]] );
    });
});
