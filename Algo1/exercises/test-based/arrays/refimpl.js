var ReferenceImplementations;
(function (ReferenceImplementations) {
    function contains(xs, x) {
        for (var i = 0; i !== xs.length; ++i) {
            if (xs[i] === x) {
                return true;
            }
        }

        return false;
    }
    ReferenceImplementations.contains = contains;

    function sum(xs) {
        var result = 0;

        for (var i = 0; i !== xs.length; ++i) {
            result += xs[i];
        }

        return result;
    }
    ReferenceImplementations.sum = sum;

    function product(xs) {
        var result = 1;

        for (var i = 0; i !== xs.length; ++i) {
            result *= xs[i];
        }

        return result;
    }
    ReferenceImplementations.product = product;

    function average(xs) {
        return sum(xs) / xs.length;
    }
    ReferenceImplementations.average = average;

    function incrementEachItem(xs) {
        for (var i = 0; i !== xs.length; ++i) {
            xs[i]++;
        }
    }
    ReferenceImplementations.incrementEachItem = incrementEachItem;

    function countZeros(xs) {
        var result = 0;

        for (var i = 0; i !== xs.length; ++i) {
            if (xs[i] === 0) {
                ++result;
            }
        }

        return result;
    }
    ReferenceImplementations.countZeros = countZeros;

    function firstIndexOf(x, xs) {
        for (var i = 0; i !== xs.length; ++i) {
            if (xs[i] === x) {
                return i;
            }
        }

        return -1;
    }
    ReferenceImplementations.firstIndexOf = firstIndexOf;

    function lastIndexOf(x, xs) {
        for (var i = xs.length - 1; i >= 0; --i) {
            if (xs[i] === x) {
                return i;
            }
        }

        return -1;
    }
    ReferenceImplementations.lastIndexOf = lastIndexOf;

    function range(a, b) {
        if (a > b) {
            return [];
        } else {
            var result = new Array(b - a + 1);

            for (var i = 0; i !== result.length; ++i) {
                result[i] = a + i;
            }

            return result;
        }
    }
    ReferenceImplementations.range = range;

    function reverse(xs) {
        for (var i = 0; 2 * i < xs.length; ++i) {
            var j = xs.length - i - 1;

            var temp = xs[i];
            xs[i] = xs[j];
            xs[j] = temp;
        }
    }
    ReferenceImplementations.reverse = reverse;

    function isPalindrome(xs) {
        for (var i = 0; i < xs.length / 2; ++i) {
            if (xs[i] !== xs[xs.length - i - 1]) {
                return false;
            }
        }

        return true;
    }
    ReferenceImplementations.isPalindrome = isPalindrome;

    function minimum(xs) {
        var result = xs[0];

        for (var i = 1; i < xs.length; ++i) {
            if (xs[i] < result) {
                result = xs[i];
            }
        }

        return result;
    }
    ReferenceImplementations.minimum = minimum;

    function maximum(xs) {
        var result = xs[0];

        for (var i = 1; i < xs.length; ++i) {
            if (xs[i] > result) {
                result = xs[i];
            }
        }

        return result;
    }
    ReferenceImplementations.maximum = maximum;

    function isIncreasing(xs) {
        if (xs.length === 0) {
            return true;
        } else {
            var last = xs[0];

            for (var i = 0; i !== xs.length; ++i) {
                if (xs[i] < last) {
                    return false;
                } else {
                    last = xs[i];
                }
            }

            return true;
        }
    }
    ReferenceImplementations.isIncreasing = isIncreasing;

    function isDecreasing(xs) {
        if (xs.length === 0) {
            return true;
        } else {
            var last = xs[0];

            for (var i = 0; i !== xs.length; ++i) {
                if (xs[i] > last) {
                    return false;
                } else {
                    last = xs[i];
                }
            }

            return true;
        }
    }
    ReferenceImplementations.isDecreasing = isDecreasing;

    function areEqual(xs, ys) {
        if (xs.length !== ys.length) {
            return false;
        } else {
            for (var i = 0; i !== xs.length; ++i) {
                if (xs[i] !== ys[i]) {
                    return false;
                }
            }

            return true;
        }
    }
    ReferenceImplementations.areEqual = areEqual;

    function alternates(xs) {
        var result = [[], []];

        for (var i = 0; i !== xs.length; ++i) {
            result[i % 2].push(xs[i]);
        }

        return result;
    }
    ReferenceImplementations.alternates = alternates;

    function lengthOfLongestIncreasingSubarray(xs) {
        if (xs.length === 0) {
            return 0;
        } else {
            var result = 1;
            var currentMaximalLength = 1;
            var lastValue = xs[0];

            for (var i = 1; i < xs.length; ++i) {
                var currentValue = xs[i];

                if (currentValue >= lastValue) {
                    currentMaximalLength++;

                    if (currentMaximalLength > result) {
                        result = currentMaximalLength;
                    }
                } else {
                    currentMaximalLength = 1;
                }

                lastValue = currentValue;
            }

            return result;
        }
    }
    ReferenceImplementations.lengthOfLongestIncreasingSubarray = lengthOfLongestIncreasingSubarray;
})(ReferenceImplementations || (ReferenceImplementations = {}));
