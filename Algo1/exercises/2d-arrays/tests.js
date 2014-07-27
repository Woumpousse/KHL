var tests = ( function() {
    function createGrid(width, height, value) {
        var result = new Array(width);

        for ( var i = 0; i !== width; ++i ) {
            result[i] = new Array(height);

            for ( var j = 0; j !== height; ++j ) {
                result[i][j] = value;
            }
        }

        return result;
    }

    function width(xss) {
        return xss.length;
    }

    function height(xss) {
        return xss[0].length;
    }

    function zigZag(width, height) {
        var result = createGrid(width, height, 0);

        var i = 0;
        var x = 0;
        var dx = 1;

        for ( var y = 0; y !== height; ++y ) {
            while ( 0 <= x && x < width ) {
                result[x][y] = i;
                ++i;
                x += dx;
            }
            dx = -dx;
            x += dx;
        }

        return result;
    }

    function getRow(xss, row) {
        var result = new Array( width(xss) );

        for ( var col = 0; col !== result.length; ++col ) {
            result[col] = xss[col][row];
        }

        return result;
    }

    return { createGrid: { referenceImplementation: createGrid,
                           inputs: [ [ 1, 1, 1 ],
                                     [ 1, 2, 0 ],
                                     [ 2, 1, "a" ],
                                     [ 2, 2, [0] ],
                                     [ 10, 10, 0 ]
                                   ]
                         },
             width: { referenceImplementation: width,
                      inputs: [ [ createGrid(1,1,0) ],
                                [ createGrid(1,2,0) ],
                                [ createGrid(2,1,0) ],
                                [ createGrid(2,2,1) ],
                                [ createGrid(5,3,9) ]
                              ]
                    },
             height: { referenceImplementation: height,
                       inputs: [ [ createGrid(1,1,0) ],
                                 [ createGrid(1,2,0) ],
                                 [ createGrid(2,1,0) ],
                                 [ createGrid(2,2,1) ],
                                 [ createGrid(5,3,9) ]
                               ]
                     },
             zigZag: { referenceImplementation: zigZag,
                       inputs: [ [1, 1],
                                 [1, 2],
                                 [1, 3],
                                 [2, 1],
                                 [3, 1],
                                 [2, 2],
                                 [2, 3],
                                 [3, 2],
                                 [3, 3]
                               ]
                     },
             getRow: { referenceImplementation: getRow,
                       inputs: [ [ zigZag(1, 1), 0 ],
                                 [ zigZag(1, 2), 0 ],
                                 [ zigZag(1, 2), 1 ],
                                 [ zigZag(2, 1), 0 ],
                                 [ zigZag(2, 2), 0 ],
                                 [ zigZag(2, 2), 1 ],
                                 [ zigZag(5, 5), 0 ],
                                 [ zigZag(5, 5), 1 ],
                                 [ zigZag(5, 5), 2 ],
                                 [ zigZag(5, 5), 3 ],
                                 [ zigZag(5, 5), 4 ]
                               ]
                     }
           };
})();


unitTests( tests, this );
