function getUrlVars()
{
    var vars = [], hash;
    var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
    for(var i = 0; i < hashes.length; i++)
    {
        hash = hashes[i].split('=');
        vars.push(hash[0]);
        vars[hash[0]] = hash[1];
    }
    return vars;
}

String.prototype.format = function() {
    var result = this;
    
    for (var i = 0; i != arguments.length; i++) {
	var regEx = new RegExp("\\{" + i + "\\}", "gm");
	result = result.replace(regEx, arguments[i]);
    }
	
    return result;
};

Array.prototype.toString = function() {
    var result = "[";
    for ( var i = 0; i != this.length; ++i ) {
        if ( i !== 0 ) result += ",";
        result += this[i].toString();
    }
    result += "]";

    return result;
};

function lexicographical(suborder) {
    return function ( xs, ys ) {
        var i = 0;
        var j = 0;

        while ( i < xs.length && j < ys.length ) {
            var cmp = suborder(xs[i], ys[i]);

            if ( cmp < 0 ) {
                return -1;
            }
            else if ( cmp > 0 ) {
                return 1;
            }

            ++i;
            ++j;
        }

        return xs.length - ys.length;
    };
}

Array.prototype.eachIndex = function (f) {
    for ( var i = 0; i != length; ++i ) {
        f(i);
    }
};

Array.initialize = function (length, f) {
    var result = new Array(length);

    result.eachIndex( function (index) {
        result[index] = f(index);
    } );

    return result;
};

Array.prototype.isPermutationOf = function (that, eq) {
    if ( this.length != that.length ) {
        return false;
    }
    else {
        var eq = eq ? eq : function (x, y) { return x === y; };
        var visited = Array.initialize( this.length, function () { return false; } );
        var i = 0;
        var j;
        
        while ( i < this.length ) {
            while ( j < that.length && visited[j] && !eq(this[i], that[j]) ) {
                ++j;
            }

            if ( j == that.length ) {
                return false;
            }
            else {
                visited[j] = true;
                ++i;
            }
        }

        return true;
    }
}

Array.prototype.sum = function () {
    return _.reduce(this, function (acc, x) { return acc + x; }, 0);
}

Array.prototype.removeAt = function(idx) {
    return this.slice(0, idx).concat(this.slice(idx + 1));
}

Array.prototype.isSubsetOf = function (that) {
    if ( this.length === 0 ) {
        return true;
    }
    else {
        var idx = _.indexOf(that, this[0]);

        return idx !== -1 && this.slice(1).isSubsetOf( that.removeAt(idx) );
    }
}




/*
  If false, no test cases are shown for X if no function for X has been defined.
*/
var forceShow = getUrlVars()['showall'] === 'true';

function deepEqualChecker(assert, input, expected, received, message) {
    assert.deepEqual(expected, received, message);
}

function permutationChecker(assert, input, expected, received, message) {
    assert.ok( expected !== undefined && expected.isPermutationOf(received), message );
}


function unitTests(tests, student) {
    for ( var testFunctionName in tests ) {
        (function () { // New scope is necessary, since tests are not ran immediately
            var functionName = testFunctionName;
            QUnit.module(functionName);

            // Check if student implemented test
            QUnit.test( "Checking for existence of {0}".format(functionName), function (assert) {
                // (Cannot use local "tested" here because execution is postponed and "tested" might be assigned to later, making this test succeed undeservedly)
                assert.ok( student[functionName] !== undefined, "Function {0} does not exist".format(functionName) );
            } );

            // Get function to be tested
            var tested = student[functionName];

            // Use dummy implementation if necessary
            if ( forceShow ) {
                tested = tested || function() { };
            }

            // Only go further if student implemented test
            if ( tested !== undefined ) {
                // Get test data
                var testData = tests[functionName];

                // Get reference implementation
                var solution = testData.referenceImplementation;

                // Get specialized checker
                var checker = testData.checker ? testData.checker : deepEqualChecker;

                // For each test case
                _.each(testData.inputs, function (input) {
                    // Clone the input for the student
                    var studentInput = clone(input);

                    // Get the student result
                    var result = tested.apply( null, studentInput );

                    // Clone the input for the reference implementation
                    var refInput = clone(input);

                    // Get the reference implementation's result
                    var expectedResult = solution.apply( null, refInput );

                    // Check for correctness
                    QUnit.test( "Input: {0}, Expected: {1}".format(input, expectedResult), function (assert) {
                        assert.deepEqual( refInput, studentInput, "Inputs must be modified in the same way" );
                        checker( assert, input, result, expectedResult, "Got {0}".format(result) );
                    } );
                } );
            }
        } )();
    }
}
