defineTests(function (originalTest) {
    var zigZag = Solutions.zigZag;

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

    test(Solutions.createGrid, function (builder) {
        builder.addInput( 1, 1, 1 );
        builder.addInput( 1, 2, 0 );
        builder.addInput( 2, 1, "a" );
        builder.addInput( 2, 2, [0] );
        builder.addInput( 10, 10, 0 );
    });

    test(Solutions.arrayLengths, function (builder) {
        builder.addInput( [[]] );
        builder.addInput( [[1]] );
        builder.addInput( [[1],[1]] );
        builder.addInput( [[1,2],[1]] );
        builder.addInput( [[1],[1,2]] );
        builder.addInput( [[], [], []] );
        builder.addInput( [[1,2],[1,2]] );
    });

    test(Solutions.isRectangular, function (builder) {
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

    test(Solutions.width, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });

    test(Solutions.height, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });

    test(Solutions.isSquare, function (builder) {
        builder.addInput( [[]] );
        builder.addInput( [[1]] );
        builder.addInput( [[1],[1]] );
        builder.addInput( [[1,2],[1]] );
        builder.addInput( [[1],[1,2]] );
        builder.addInput( [[], [], []] );
        builder.addInput( [[1,2],[1,2]] );

        builder.setFormatter( formatters.simple );
    });

    test(Solutions.zigZag, function (builder) {
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
    
    test(Solutions.getRow, function (builder) {
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

    test(Solutions.getColumn, function (builder) {
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

    test(Solutions.rowSums, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });

    test(Solutions.columnSums, function (builder) {
        _.each(gridInputs, function (input) {
            builder.addInput(input);
        });
    });
});
