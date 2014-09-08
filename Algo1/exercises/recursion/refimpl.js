function isVowel(c) {
    c = c.toLowerCase();

    return /^[aeiou]$/.test(c);
}

var ReferenceImplementations;
(function (ReferenceImplementations) {
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
    ReferenceImplementations.isOdd = isOdd;

    function factorial(n) {
        if (n === 0) {
            return 1;
        } else {
            return n * factorial(n - 1);
        }
    }
    ReferenceImplementations.factorial = factorial;

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
    ReferenceImplementations.vowelCount = vowelCount;

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
    ReferenceImplementations.maskVowels = maskVowels;

    function rle(str) {
        // Auxialiry function
        // Can of course also be defined outside this method body
        function aux(str, last, count) {
            if (str.length === 0) {
                return last + count;
            } else {
                var head = str.charAt(0);
                var tail = str.substring(1);

                if (head === last) {
                    return aux(tail, last, count + 1);
                } else {
                    return last + count + aux(tail, head, 1);
                }
            }
        }

        if (str.length === 0) {
            return "";
        } else {
            var head = str.charAt(0);
            var tail = str.substring(1);

            return aux(tail, head, 1);
        }
    }
    ReferenceImplementations.rle = rle;

    function compress(str) {
        // Auxialiry function
        // Can of course also be defined outside this method body
        function aux(str, last, count) {
            if (str.length === 0) {
                return last + count;
            } else {
                var head = str.charAt(0);
                var tail = str.substring(1);

                if (head === last) {
                    if (count === 9) {
                        return head + "9" + aux(tail, head, 1);
                    } else {
                        return aux(tail, head, count + 1);
                    }
                } else {
                    return last + count + aux(tail, head, 1);
                }
            }
        }

        if (str.length === 0) {
            return "";
        } else {
            var head = str.charAt(0);
            var tail = str.substring(1);

            return aux(tail, head, 1);
        }
    }
    ReferenceImplementations.compress = compress;

    function repeat(x, n) {
        if (n === 0) {
            return "";
        } else {
            return x.concat(repeat(x, n - 1));
        }
    }
    ReferenceImplementations.repeat = repeat;

    function decompress(str) {
        if (str.length === 0) {
            return "";
        } else {
            var c = str.charAt(0);
            var n = parseInt(str.charAt(1));

            return repeat(c, n).concat(decompress(str.substring(2)));
        }
    }
    ReferenceImplementations.decompress = decompress;
})(ReferenceImplementations || (ReferenceImplementations = {}));
