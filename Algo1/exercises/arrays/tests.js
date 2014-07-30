var tests = ( function() {
    function contains(xs, x) {
        for ( var i = 0; i !== xs.length; ++i ) {
            if ( xs[i] === x ) {
                return true;
            }
        }
        
        return false;
    }

    function sum(xs) {
        var result = 0;

        for ( var i = 0; i !== xs.length; ++i ) {
            result += xs[i];
        }

        return result;
    }

    function product(xs) {
        var result = 1;

        for ( var i = 0; i !== xs.length; ++i ) {
            result *= xs[i];
        }

        return result;
    }

    function incrementEachItem(xs) {
        for ( var i = 0; i !== xs.length; ++i ) {
            xs[i]++;
        }
    }

    function countZeros(xs) {
        var result = 0;

        for ( var i = 0; i !== xs.length; ++i ) {
            if ( xs[i] === 0 ) {
                ++result;
            }
        }

        return result;
    }

    function firstIndexOf(x, xs) {
        for ( var i = 0; i !== xs.length; ++i ) {
            if ( xs[i] === x ) {
                return i;
            }
        }

        return -1;
    }

    function range(a, b) {
        var result = new Array(b - a + 1);

        for ( var i = 0; i !== result.length; ++i ) {
            result[i] = a + i;
        }

        return result;
    }

    function reverse(xs) {
        for ( var i = 0; 2 * i < xs.length; ++i ) {
            var j = xs.length - i - 1;

            var temp = xs[i];
            xs[i] = xs[j];
            xs[j] = temp;
        }
    }

    return { contains: { referenceImplementation: contains,
                         inputs: [ [ [], 1 ],
                                   [ [1], 1 ],
                                   [ [0], 1 ],
                                   [ [1,2,3], 1],
                                   [ [1,2,3], 2],
                                   [ [1,2,3], 3] ]
                       },
             sum: { referenceImplementation: sum,
                    inputs: [ [ [] ],
                              [ [0] ],
                              [ [1] ],
                              [ [1,2] ],
                              [ [1,2,3] ],
                              [ [1,2,3,4,5,6,7,8,9,10] ]
                         ]
                  },
             product: { referenceImplementation: product,
                        inputs: [ [ [] ],
                                  [ [0] ],
                                  [ [1] ],
                                  [ [1,2] ],
                                  [ [1,2,3] ],
                                  [ [1,2,3,4,5,6,7,8,9,10] ],
                                  [ [1,2,3,4,0] ]
                             ]
                      },
             incrementEachItem: { referenceImplementation: incrementEachItem,
                                  inputs: [ [ [] ],
                                            [ [0] ],
                                            [ [0,0,0] ],
                                            [ [1,2,3] ]
                                          ]
                                },
             countZeros: { referenceImplementation: countZeros,
                           inputs: [ [ [] ],
                                     [ [0] ],
                                     [ [1] ],
                                     [ [0,0] ],
                                     [ [1,1] ],
                                     [ [1,0,1] ],
                                     [ [0,1,0] ],
                                     [ [1,0,0] ],
                                     [ [2,3,4] ]
                                ]
                         },
             firstIndexOf: { referenceImplementation: firstIndexOf,
                             inputs: [ [ 1, [] ],
                                       [ 1, [1] ],
                                       [ 1, [2] ],
                                       [ 2, [2] ],
                                       [ 2, [1,2,3] ],
                                       [ 3, [1,2,3] ],
                                       [ 4, [1,2,3] ]
                                     ]
                           },
             range: { referenceImplementation: range,
                      inputs: [ [1,1],
                                [1,2],
                                [1,3],
                                [2,2],
                                [2,4],
                                [1,10]
                              ]
                    },
             reverse: { referenceImplementation: reverse,
                        inputs: [ [ [] ],
                                  [ [1] ],
                                  [ [1,2] ],
                                  [ [1,2,3] ],
                                  [ [1,2,3,4] ],
                                  [ [1,2,3,4,5] ],
                                  [ [1,1,2,3,3,4,5,5,6] ]
                                ]
                        }
           };
})();

