var ReferenceImplementations;
(function (ReferenceImplementations) {
    function factorial(n) {
        var result = 1;

        for (var i = 1; i <= n; ++i) {
            result *= i;
        }

        return result;
    }
    ReferenceImplementations.factorial = factorial;

    function countDigits(n) {
        var result;

        if (n === 0) {
            result = 1;
        } else {
            result = 0;
            if (n < 0) {
                n = -n;
            }

            while (n > 0) {
                n = Math.floor(n / 10);
                result++;
            }
        }

        return result;
    }
    ReferenceImplementations.countDigits = countDigits;

    function gcd(a, b) {
        var result;

        result = a;
        while (a % result !== 0 || b % result !== 0) {
            result--;
        }

        return result;
    }
    ReferenceImplementations.gcd = gcd;

    function lcm(a, b) {
        var result;

        result = a;
        while (result % a !== 0 || result % b !== 0) {
            result++;
        }

        return result;
    }
    ReferenceImplementations.lcm = lcm;

    function countTrailingZeros(n) {
        var result;

        if (n === 0) {
            result = 1;
        } else {
            result = 0;
            while (n !== 0 && n % 10 === 0) {
                n /= 10;
                result++;
            }
        }

        return result;
    }
    ReferenceImplementations.countTrailingZeros = countTrailingZeros;

    function countZeros(n) {
        var result;

        if (n === 0) {
            result = 1;
        } else {
            if (n < 0) {
                n = -n;
            }

            result = 0;
            while (n !== 0) {
                if (n % 10 === 0) {
                    result++;
                }

                n = Math.floor(n / 10);
            }
        }

        return result;
    }
    ReferenceImplementations.countZeros = countZeros;

    function rangeSum(a, b) {
        var result;

        result = 0;

        for (var i = a; i <= b; ++i) {
            result += i;
        }

        return result;
    }
    ReferenceImplementations.rangeSum = rangeSum;

    function isPrime(n) {
        var result;

        if (n < 2) {
            result = false;
        } else {
            result = true;
            var i = 2;
            while (i * i <= n && result) {
                if (n % i === 0) {
                    result = false;
                }

                ++i;
            }
        }

        return result;
    }
    ReferenceImplementations.isPrime = isPrime;

    function sumDigits(n) {
        var total = 0;

        while (n > 0) {
            total += n % 10;
            n = Math.floor(n / 10);
        }

        return total;
    }
    ReferenceImplementations.sumDigits = sumDigits;

    function greatestDigitProduct(n) {
        if (n >= 10) {
            var best = 0;
            var product = 1;

            while (n > 0) {
                var digit = n % 10;
                n = Math.floor(n / 10);

                if (digit === 0) {
                    best = Math.max(best, product);
                    product = 1;
                } else {
                    product *= digit;
                }
            }

            best = Math.max(best, product);

            return best;
        } else {
            return -1;
        }
    }
    ReferenceImplementations.greatestDigitProduct = greatestDigitProduct;

    function greatestSumOfDigitTriples(n) {
        if (n >= 100) {
            var best = 0;
            var d1, d2, d3;

            d1 = n % 10;
            n = Math.floor(n / 10);
            d2 = n % 10;
            n = Math.floor(n / 10);
            d3 = n % 10;

            best = d1 + d2 + d3;

            while (n > 0) {
                d1 = d2;
                d2 = d3;
                d3 = n % 10;
                n = Math.floor(n / 10);

                best = Math.max(d1 + d2 + d3, best);
            }

            return best;
        } else {
            return -1;
        }
    }
    ReferenceImplementations.greatestSumOfDigitTriples = greatestSumOfDigitTriples;
})(ReferenceImplementations || (ReferenceImplementations = {}));
