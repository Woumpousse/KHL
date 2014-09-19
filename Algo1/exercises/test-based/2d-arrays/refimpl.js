var ReferenceImplementations;
(function (ReferenceImplementations) {
    function createGrid(width, height, value) {
        var result = new Array(width);

        for (var i = 0; i !== width; ++i) {
            result[i] = new Array(height);

            for (var j = 0; j !== height; ++j) {
                result[i][j] = value;
            }
        }

        return result;
    }
    ReferenceImplementations.createGrid = createGrid;

    function arrayLengths(xss) {
        var result = new Array(xss.length);

        for (var i = 0; i !== xss.length; ++i) {
            result[i] = xss[i].length;
        }

        return result;
    }
    ReferenceImplementations.arrayLengths = arrayLengths;

    function allEqual(xs) {
        if (xs.length == 0) {
            return true;
        } else {
            for (var i = 1; i !== xs.length; ++i) {
                if (xs[i] !== xs[0]) {
                    return false;
                }
            }

            return true;
        }
    }
    ReferenceImplementations.allEqual = allEqual;

    function isRectangular(xss) {
        return allEqual(arrayLengths(xss));
    }
    ReferenceImplementations.isRectangular = isRectangular;

    function width(xss) {
        return xss.length;
    }
    ReferenceImplementations.width = width;

    function height(xss) {
        return xss[0].length;
    }
    ReferenceImplementations.height = height;

    function isSquare(xss) {
        return isRectangular(xss) && width(xss) === height(xss);
    }
    ReferenceImplementations.isSquare = isSquare;

    function zigZag(width, height) {
        var result = createGrid(width, height, 0);

        var i = 0;
        var x = 0;
        var dx = 1;

        for (var y = 0; y !== height; ++y) {
            while (0 <= x && x < width) {
                result[x][y] = i;
                ++i;
                x += dx;
            }
            dx = -dx;
            x += dx;
        }

        return result;
    }
    ReferenceImplementations.zigZag = zigZag;

    function getRow(xss, row) {
        var result = new Array(width(xss));

        for (var col = 0; col !== result.length; ++col) {
            result[col] = xss[col][row];
        }

        return result;
    }
    ReferenceImplementations.getRow = getRow;

    function getColumn(xss, col) {
        var result = new Array(height(xss));

        for (var row = 0; row !== result.length; ++row) {
            result[row] = xss[col][row];
        }

        return result;
    }
    ReferenceImplementations.getColumn = getColumn;

    function sum(xs) {
        var result = 0;

        for (var i = 0; i !== xs.length; ++i) {
            result += xs[i];
        }

        return result;
    }
    ReferenceImplementations.sum = sum;

    function rowSums(xss) {
        var result = new Array(height(xss));

        for (var i = 0; i !== result.length; ++i) {
            result[i] = sum(getRow(xss, i));
        }

        return result;
    }
    ReferenceImplementations.rowSums = rowSums;

    function columnSums(xss) {
        var result = new Array(width(xss));

        for (var i = 0; i !== result.length; ++i) {
            result[i] = sum(getColumn(xss, i));
        }

        return result;
    }
    ReferenceImplementations.columnSums = columnSums;

    function matrixAddition(xss, yss) {
        var result = createGrid(width(xss), height(xss), 0);

        for (var y = 0; y !== height(result); ++y) {
            for (var x = 0; x !== width(result); ++x) {
                result[x][y] = xss[x][y] + yss[x][y];
            }
        }

        return result;
    }
    ReferenceImplementations.matrixAddition = matrixAddition;

    function matrixMultiplication(xss, yss) {
        var result = createGrid(width(yss), height(xss), 0);

        for (var row = 0; row !== height(result); ++row) {
            for (var col = 0; col !== width(result); ++col) {
                for (var i = 0; i !== width(xss); ++i) {
                    result[col][row] += xss[i][row] * yss[col][i];
                }
            }
        }

        return result;
    }
    ReferenceImplementations.matrixMultiplication = matrixMultiplication;
})(ReferenceImplementations || (ReferenceImplementations = {}));
