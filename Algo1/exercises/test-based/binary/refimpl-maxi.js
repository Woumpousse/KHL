/*
Dit bestand bevat niet voor elke functie een implementatie
die aan de opgave voldoet.
*/
var ReferenceImplementations;
(function (ReferenceImplementations) {
    function isBinary(x) {
        if (x < 0) {
            return false;
        } else {
            while (x > 0) {
                var ld = x % 10;

                if (ld > 1) {
                    return false;
                }

                x = (x - ld) / 10;
            }

            return true;
        }
    }
    ReferenceImplementations.isBinary = isBinary;

    function binaryToDecimal(x) {
        if (!isBinary(x)) {
            return "invalid";
        } else {
            var rs = 0;
            var wgh = 1;

            while (x > 0) {
                var ld = x % 10;

                rs += wgh * ld;
                x = Math.floor(x / 10);
                wgh *= 2;
            }

            return rs;
        }
    }
    ReferenceImplementations.binaryToDecimal = binaryToDecimal;

    function decimalToBinary(x) {
        if (x < 0) {
            return "invalid";
        } else {
            var rs = 0;
            var wgh = 1;

            while (x > 0) {
                var ld = x % 2;

                rs += wgh * ld;
                x = Math.floor(x / 2);
                wgh *= 10;
            }

            return rs;
        }
    }
    ReferenceImplementations.decimalToBinary = decimalToBinary;

    function binaryAdd(x, y) {
        if (!isBinary(x) || !isBinary(y)) {
            return "invalid";
        } else {
            var dx = binaryToDecimal(x);
            var dy = binaryToDecimal(y);
            var ds = dx + dy;
            var bs = decimalToBinary(ds);

            return bs;
        }
    }
    ReferenceImplementations.binaryAdd = binaryAdd;
})(ReferenceImplementations || (ReferenceImplementations = {}));
