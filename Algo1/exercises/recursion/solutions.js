function isVowel(c) {
    c = c.toLowerCase();

    return /^[aeiou]$/.test(c);
}

var Solutions;
(function (Solutions) {
    function isOdd(n) {
        if (n < 0) {
            isOdd(-n);
        } else if (n === 0) {
            return false;
        } else if (n === 1) {
            return true;
        } else {
            return isOdd(n - 2);
        }
    }
    Solutions.isOdd = isOdd;

    function factorial(n) {
        if (n === 0) {
            return 1;
        } else {
            return n * factorial(n - 1);
        }
    }
    Solutions.factorial = factorial;

    function sum(xs) {
        if (xs.length === 0) {
            return 0;
        } else {
            return xs[0] + sum(xs.slice(1));
        }
    }
    Solutions.sum = sum;

    function product(xs) {
        if (xs.length === 0) {
            return 1;
        } else {
            return xs[0] * product(xs.slice(1));
        }
    }
    Solutions.product = product;

    function countZeros(xs) {
        if (xs.length === 0) {
            return 0;
        } else if (xs[0] === 0) {
            return 1 + countZeros(xs.slice(1));
        } else {
            return countZeros(xs.slice(1));
        }
    }
    Solutions.countZeros = countZeros;

    function removeZeros(xs) {
        if (xs.length === 0) {
            return [];
        } else if (xs[0] === 0) {
            return removeZeros(xs.slice(1));
        } else {
            return [xs[0]].concat(removeZeros(xs.slice(1)));
        }
    }
    Solutions.removeZeros = removeZeros;

    function firstIndexOf(x, xs) {
        if (xs.length === 0) {
            return -1;
        } else if (x === xs[0]) {
            return 0;
        } else {
            var idx = firstIndexOf(x, xs.slice(1));

            if (idx == -1) {
                return -1;
            } else {
                return idx + 1;
            }
        }
    }
    Solutions.firstIndexOf = firstIndexOf;

    function removeAt(xs, index) {
        if (xs.length === 0) {
            return [];
        } else if (index === 0) {
            return xs.slice(1);
        } else {
            return [xs[0]].concat(removeAt(xs.slice(1), index - 1));
        }
    }
    Solutions.removeAt = removeAt;

    function isSubsetOf(xs, ys) {
        if (xs.length === 0) {
            return true;
        } else {
            var idx = firstIndexOf(xs[0], ys);

            return idx !== -1 && isSubsetOf(xs.slice(1), removeAt(ys, idx));
        }
    }
    Solutions.isSubsetOf = isSubsetOf;

    function range(a, b) {
        if (a > b) {
            return [];
        } else {
            return [a].concat(range(a + 1, b));
        }
    }
    Solutions.range = range;

    function duplicateEachItem(xs) {
        if (xs.length === 0) {
            return [];
        } else {
            return [xs[0], xs[0]].concat(duplicateEachItem(xs.slice(1)));
        }
    }
    Solutions.duplicateEachItem = duplicateEachItem;

    function subarrays(xs) {
        if (xs.length === 0) {
            return [[]];
        } else {
            var subresult = subarrays(xs.slice(1));
            var result = subresult.slice(0);

            for (var i = 0; i !== subresult.length; ++i) {
                result.unshift([xs[0]].concat(subresult[i]));
            }

            return result;
        }
    }
    Solutions.subarrays = subarrays;

    function permutations(xs) {
        if (xs.length === 0) {
            return [[]];
        } else {
            var result = [];

            for (var i = 0; i !== xs.length; ++i) {
                var picked = xs[i];
                var rest = xs.slice(0, i).concat(xs.slice(i + 1));

                var restPermutations = permutations(rest);

                for (var j = 0; j !== restPermutations.length; ++j) {
                    result.push([picked].concat(restPermutations[j]));
                }
            }

            return result;
        }
    }
    Solutions.permutations = permutations;

    function knapsack(n, ns) {
        if (n === 0) {
            return [];
        } else if (n < 0 || ns.length == 0) {
            return null;
        } else {
            var head = ns[0];
            var tail = ns.slice(1);
            var result = knapsack(n - ns[0], ns.slice(1));

            if (result !== null) {
                return [head].concat(result);
            } else {
                return knapsack(n, ns.slice(1));
            }
        }
    }
    Solutions.knapsack = knapsack;

    function vowelCount(str) {
        if (str.length === 0) {
            return 0;
        } else {
            var head = str.charAt(0);
            var tail = str.substring(1);
            var tailVowelCount = vowelCount(tail);

            if (isVowel(head)) {
                return 1 + tailVowelCount;
            } else {
                return tailVowelCount;
            }
        }
    }
    Solutions.vowelCount = vowelCount;

    function maskVowels(str) {
        if (str.length === 0) {
            return "";
        } else {
            var head = str.charAt(0);
            var tail = str.substring(1);
            var maskedTail = maskVowels(tail);

            if (isVowel(head)) {
                return "*".concat(maskedTail);
            } else {
                return head.concat(maskedTail);
            }
        }
    }
    Solutions.maskVowels = maskVowels;
})(Solutions || (Solutions = {}));
