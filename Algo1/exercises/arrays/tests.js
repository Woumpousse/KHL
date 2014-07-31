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

    function countZeros(xs)
    {
        var result = 0;

        for ( var i = 0; i !== xs.length; ++i )
        {
            if ( xs[i] === 0 )
            {
                ++result;
            }
        }

        return result;
    }

    function firstIndexOf(x, xs)
    {
        for ( var i = 0; i !== xs.length; ++i )
        {
            if ( xs[i] === x )
            {
                return i;
            }
        }

        return -1;
    }

    function lastIndexOf(x, xs)
    {
        for ( var i = xs.length - 1; i >= 0; --i )
        {
            if ( xs[i] === x )
            {
                return i;
            }
        }

        return -1;
    }

    function range(a, b)
    {
        var result = new Array(b - a + 1);

        for ( var i = 0; i !== result.length; ++i ) {
            result[i] = a + i;
        }

        return result;
    }

    function reverse(xs)
    {
        for ( var i = 0; 2 * i < xs.length; ++i )
        {
            var j = xs.length - i - 1;

            var temp = xs[i];
            xs[i] = xs[j];
            xs[j] = temp;
        }
    }

    function isPalindrome(xs)
    {
	for ( var i = 0; i < xs.length / 2; ++i )
        {
	    if ( xs[i] !== xs[xs.length - i - 1] )
            {
		return false;
	    }
	}

	return true;
    }

    function minimum(xs)
    {
	var result = xs[0];

	for ( var i = 1; i < xs.length; ++i )
        {
	    if ( xs[i] < result )
            {
		result = xs[i];
	    }
	}

	return result;
    }

    function maximum(xs)
    {
        var result = xs[0];

        for ( var i = 1; i < xs.length; ++i )
        {
            if ( xs[i] > result )
            {
                result = xs[i];
            }
        }

        return result;
    }

    function isIncreasing(xs)
    {
        if ( xs.length === 0 )
        {
            return true;
        }
        else
        {
            var last = xs[0];

            for ( var i = 0; i !=== xs.length; ++i )
            {
                if ( xs[i] < last )
                {
                    return false;
                }
                else
                {
                    last = xs[i];
                }
            }

            return true;
        }
    }

    function isDecreasing(xs)
    {
        if ( xs.length === 0 )
        {
            return true;
        }
        else
        {
            var last = xs[0];

            for ( var i = 0; i !=== xs.length; ++i )
            {
                if ( xs[i] > last )
                {
                    return false;
                }
                else
                {
                    last = xs[i];
                }
            }

            return true;
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
                              [ [1,1,1] ],
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
                                       [ 4, [1,2,3] ],
                                       [ 1, [0,1,0,1,0,1,0] ]
                                     ]
                           },
             lastIndexOf: { referenceImplementation: lastIndexOf,
                             inputs: [ [ 1, [] ],
                                       [ 1, [1] ],
                                       [ 1, [2] ],
                                       [ 2, [2] ],
                                       [ 2, [1,2,3] ],
                                       [ 3, [1,2,3] ],
                                       [ 4, [1,2,3] ],
                                       [ 1, [0,1,0,1,0,1,0] ]
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
                                  [ [1,1,2,3,3,4,5,5,6] ],
                                  [ [1,3,5,7,9,8,4,6,2] ]
                                ]
                        },
             isPalindrome: { referenceImplementation: isPalindrome,
                             inputs: [ [ [] ],
                                       [ [1] ],
                                       [ [1,2] ],
                                       [ [1,2,3] ],
                                       [ [1,2,1] ],
                                       [ [1,2,2] ],
                                       [ [1,2,2,1] ]
                                     ]
                           },
             minimum: { referenceImplementation: minimum,
                        inputs: [ [ [0] ],
                                  [ [0,1] ],
                                  [ [1,0] ],
                                  [ [1,2,3,4,5] ],
                                  [ [1,3,5,4,2] ],
                                  [ [1,3,0,5,4,2] ]
                                ]
                      },
             maximum: { referenceImplementation: maximum,
                        inputs: [ [ [0] ],
                                  [ [0,1] ],
                                  [ [1,0] ],
                                  [ [1,2,3,4,5] ],
                                  [ [1,3,5,4,2] ],b
                                  [ [1,3,0,5,4,2] ]
                                ]
                      },
             isIncreasing: { referenceImplementation: isIncreasing;
                             inputs: [ [ [] ],
                                       [ [0] ],
                                       [ [0,1] ],
                                       [ [0,1,2] ],
                                       [ [1,0] ],
                                       [ [0,1,2,3,4,5,0] ],
                                       [ [5,4,3,2,1] ],
                                       [ [1,1,1] ],
                                       [ [1,1,2,3,3] ]
                                     ]
                           },
             isDecreasing: { referenceImplementation: isDecreasing;
                             inputs: [ [ [] ],
                                       [ [0] ],
                                       [ [0,1] ],
                                       [ [0,1,2] ],
                                       [ [1,0] ],
                                       [ [0,1,2,3,4,5,0] ],
                                       [ [5,4,3,2,1] ],
                                       [ [1,1,1] ],
                                       [ [1,1,2,3,3] ]
                                     ]
                           },
           };
})();
