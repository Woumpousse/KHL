function random() {
    return 0;
}

var ReferenceImplementations;
(function (ReferenceImplementations) {
    function randomInteger(a, b) {
        return Math.floor(random() * (b - a)) + a;
    }
    ReferenceImplementations.randomInteger = randomInteger;

    function throwDie() {
        return randomInteger(1, 7);
    }
    ReferenceImplementations.throwDie = throwDie;

    function sumDice(n) {
        var result = 0;

        for (var i = 0; i !== n; ++i) {
            result += throwDie();
        }

        return result;
    }
    ReferenceImplementations.sumDice = sumDice;

    function countSumDice(diceCount, n, sum) {
        var result = 0;

        for (var i = 0; i !== n; ++i) {
            if (sumDice(diceCount) === sum) {
                ++result;
            }
        }

        return result;
    }
    ReferenceImplementations.countSumDice = countSumDice;

    function mostFrequentSum(diceCount) {
        var bestSum = 0;
        var bestSumCount = 0;

        for (var i = 1; i !== 6 * diceCount; ++i) {
            var count = countSumDice(diceCount, 1000, i);

            if (count > bestSumCount) {
                bestSumCount = count;
                bestSum = i;
            }
        }

        return bestSum;
    }
    ReferenceImplementations.mostFrequentSum = mostFrequentSum;

    function product(a, b) {
        return a * b;
    }
    ReferenceImplementations.product = product;

    function quotient(a, b) {
        if (a < 0 || b <= 0) {
            return "invalid";
        } else {
            return Math.floor(a / b);
        }
    }
    ReferenceImplementations.quotient = quotient;

    function modulo(a, b) {
        if (a < 0 || b <= 0) {
            return "invalid";
        } else {
            return a % b;
        }
    }
    ReferenceImplementations.modulo = modulo;

    function pow(a, b) {
        if ((a === 0 && b === 0) || b < 0) {
            return "invalid";
        } else {
            return Math.pow(a, b);
        }
    }
    ReferenceImplementations.pow = pow;

    function calc(op, a, b) {
        if (op === "+") {
            return a + b;
        } else if (op === "*") {
            return product(a, b);
        } else if (op === "/") {
            return quotient(a, b);
        } else if (op === "%") {
            return modulo(a, b);
        } else if (op === "^") {
            return pow(a, b);
        } else {
            return "invalid";
        }
    }
    ReferenceImplementations.calc = calc;
})(ReferenceImplementations || (ReferenceImplementations = {}));
