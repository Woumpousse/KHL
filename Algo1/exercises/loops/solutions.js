var Solutions;
(function (Solutions) {
    function factorial(n) {
        var result = 1;

        for (var i = 1; i <= n; ++i) {
            result *= i;
        }

        return result;
    }
    Solutions.factorial = factorial;

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
    Solutions.countDigits = countDigits;

    function gcd(a, b) {
        var result;

        result = a;
        while (a % result !== 0 || b % result !== 0) {
            result--;
        }

        return result;
    }
    Solutions.gcd = gcd;

    function lcm(a, b) {
        var result;

        result = a;
        while (result % a !== 0 || result % b !== 0) {
            result++;
        }

        return result;
    }
    Solutions.lcm = lcm;

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
    Solutions.countTrailingZeros = countTrailingZeros;

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
    Solutions.countZeros = countZeros;

    function rangeSum(a, b) {
        var result;

        result = 0;

        for (var i = a; i <= b; ++i) {
            result += i;
        }

        return result;
    }
    Solutions.rangeSum = rangeSum;

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
    Solutions.isPrime = isPrime;
})(Solutions || (Solutions = {}));
