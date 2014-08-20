defineTests(function (originalTest) {
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

    test(Solutions.zeros, function (builder) {
        builder.addInput(0, 1);
        builder.addInput(10, 1);
        builder.addInput(200, 2);
        builder.addInput(5000, 3);
        builder.addInput(1001, 0);
        builder.addInput(10010, 1);
    });

    test(Solutions.createGrid, function (builder) {
        builder.addInput(1, 1, 0);
        builder.addInput(1, 2, 1);
        builder.addInput(2, 1, 2);
        builder.addInput(2, 2, 3);
    });

    test(Solutions.width, function (builder) {
        builder.addInput(Solutions.createGrid(1, 1, 0));
        builder.addInput(Solutions.createGrid(2, 1, 0));
        builder.addInput(Solutions.createGrid(1, 2, 0));
        builder.addInput(Solutions.createGrid(3, 3, 0));
    });

    test(Solutions.height, function (builder) {
        builder.addInput(Solutions.createGrid(1, 1, 0));
        builder.addInput(Solutions.createGrid(2, 1, 0));
        builder.addInput(Solutions.createGrid(1, 2, 0));
        builder.addInput(Solutions.createGrid(3, 3, 0));
    });

    test(Solutions.slideOne, function (builder) {
        builder.addInput( [ [null], [2] ], 1, 0 );
        builder.addInput( [ [1], [2] ], 1, 0 );
        builder.addInput( [ [2], [2] ], 1, 0 );
        builder.addInput( [ [2], [2] ], 0, 0 );
        builder.addInput( [ [2,1], [2,1] ], 1, 0 );
        builder.addInput( [ [2,1], [2,1] ], 1, 1 );
        builder.addInput( [ [2,1], [2,1] ], 0, 1 );
        builder.addInput( [ [null], [null], [null], [2] ], 3, 0 );
        builder.addInput( [ [null], [2], [null], [2] ], 3, 0 );
    });

    test(Solutions.slideAll, function (builder) {
        builder.addInput( [ [null], [2] ] );
        builder.addInput( [ [null], [null], [null], [2] ] );
        builder.addInput( [ [1], [2] ] );
        builder.addInput( [ [2], [2] ] );
        builder.addInput( [ [null], [2], [null], [2] ] );
        builder.addInput( [ [null, 1], [2, 1] ] );
        builder.addInput( [ [null, 2], [2, 1] ] );
    });

    test(Solutions.rotateClockwise, function (builder) {
        builder.addInput( [[1]] );
        builder.addInput( [[1], [2]] );
        builder.addInput( [[1,2]] );
        builder.addInput( [[1,3],[2,4]] );
        builder.addInput( [[1,2,3],[4,5,6],[7,8,9]] );
    });

    test(Solutions.rotateCounterClockwise, function (builder) {
        builder.addInput( [[1]] );
        builder.addInput( [[1], [2]] );
        builder.addInput( [[1,2]] );
        builder.addInput( [[1,3],[2,4]] );
        builder.addInput( [[1,2,3],[4,5,6],[7,8,9]] );
    });
});
