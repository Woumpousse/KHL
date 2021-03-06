var ReferenceImplementations;
(function (ReferenceImplementations) {
    function average(a, b) {
        var result;

        result = (a + b) / 2;

        return result;
    }
    ReferenceImplementations.average = average;

    function isOdd(n) {
        var result;

        if (n % 2 == +1) {
            result = true;
        } else {
            result = false;
        }

        return result;
    }
    ReferenceImplementations.isOdd = isOdd;

    function isEven(n) {
        var result;

        if (n % 2 == +0) {
            result = true;
        } else {
            result = false;
        }

        return result;
    }
    ReferenceImplementations.isEven = isEven;

    function endsInZero(n) {
        var result;

        if (n % 10 === 0) {
            result = true;
        } else {
            result = false;
        }

        return result;
    }
    ReferenceImplementations.endsInZero = endsInZero;

    function endsInThreeZeros(n) {
        var result;

        if ((n <= -1000 || n >= 1000) && n % 1000 === 0) {
            result = true;
        } else {
            result = false;
        }

        return result;
    }
    ReferenceImplementations.endsInThreeZeros = endsInThreeZeros;

    function minimumOfTwo(a, b) {
        var result;

        if (a < b) {
            result = a;
        } else {
            result = b;
        }

        return result;
    }
    ReferenceImplementations.minimumOfTwo = minimumOfTwo;

    function abs(a) {
        var result;

        if (a >= 0) {
            result = a;
        } else {
            result = -a;
        }

        return result;
    }
    ReferenceImplementations.abs = abs;

    function maximumOfThree(a, b, c) {
        var result;

        if (a >= b && a >= c) {
            result = a;
        } else if (b >= a && b >= c) {
            result = b;
        } else {
            result = c;
        }

        return result;
    }
    ReferenceImplementations.maximumOfThree = maximumOfThree;

    function sort(a, b, c) {
        var x, y, z;

        if (a <= b && a <= c) {
            x = a;

            if (b <= c) {
                y = b;
                z = c;
            } else {
                y = c;
                z = b;
            }
        } else if (b <= a && b <= c) {
            x = b;

            if (a <= c) {
                y = a;
                z = c;
            } else {
                y = c;
                z = a;
            }
        } else {
            x = c;

            if (a <= b) {
                y = a;
                z = b;
            } else {
                y = b;
                z = a;
            }
        }

        return [x, y, z];
    }
    ReferenceImplementations.sort = sort;

    function cost1(n) {
        var result;

        result = n * 5;

        return result;
    }
    ReferenceImplementations.cost1 = cost1;

    function cost2(n, k) {
        var result;

        result = n * 5 + k * 7;

        return result;
    }
    ReferenceImplementations.cost2 = cost2;

    function cost3(n, k) {
        var result;

        result = n * 5 + k * 7 + 0.5 * (n + k);

        return result;
    }
    ReferenceImplementations.cost3 = cost3;

    function cost4(n, k) {
        var result;

        result = n * 5 + k * 7;

        if (n + k < 3) {
            result += 0.5 * (n + k);
        }

        return result;
    }
    ReferenceImplementations.cost4 = cost4;

    function cost5(n, k) {
        var result;

        result = n * 5 + k * 7;

        if (result < 20 || n + k < 3) {
            result += 0.5 * (n + k);
        }

        return result;
    }
    ReferenceImplementations.cost5 = cost5;

    // TODO
    function bookOrder(n) {
        var result;

        var price;
        if (n < 100)
            price = 50;
        else if (n < 250)
            price = 45;
        else if (n < 500)
            price = 40;
        else if (n < 1000)
            price = 30;

        result = n * price;

        return result;
    }
    ReferenceImplementations.bookOrder = bookOrder;

    // TODO
    function taxes(n) {
        var result;

        result = 0;

        n -= 1000;
        if (n > 0) {
            result += (n % 500) * 0.25;
            n -= 500;

            if (n > 500) {
                result += n * 0.50;
            }
        }

        return result;
    }
    ReferenceImplementations.taxes = taxes;
})(ReferenceImplementations || (ReferenceImplementations = {}));
