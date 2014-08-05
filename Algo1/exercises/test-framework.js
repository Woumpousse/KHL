var equality = ( function () {
    function deep(x, y)
    {
        return _.isEqual(x, y);
    }

    function permutation(eq)
    {
        return function (xs, ys) {
            return xs.isPermutationOf(ys, eq);
        }
    }

    return {
        deep: deep,
        permutation: permutation
    };
} )();

var validators = ( function () {
    function identical(input, expected, received)
    {
        return equality.deep(expected, received);
    }

    function io( inputComparer, outputComparer)
    {
        return function (input, expected, received) {
            return inputComparer( expected.transformedInputs, received.transformedInputs ) &&
                outputComparer( expected.returnValue, received.returnValue );
        };
    }

    return { identical: identical, io: io };
} )();

var predicates = ( function () {
    function isArray(x)
    {
        return x instanceof Array;
    }

    function isMatrix(x)
    {
        return isArray(x) && _.every( x, function (item) {
            return isArray(item);
        } );
    }

    function constant( r )
    {
        return function( x ) { return r; }
    }

    return { isArray: isArray,
             isMatrix: isMatrix,
             any: constant(true),
             none: constant(false)
           };
} )();


function collectStudentImplementations(allTestData, studentImplementations)
{
    for ( var id in allTestData ) {
        if ( id in studentImplementations )
        {
            var testData = allTestData[id];
            var studentImplementation = studentImplementations[id];
            testData.implementation = studentImplementation;
        }
    }
}

var runResult = { Success: function ( transformedInputs, returnValue )
                  {
                      this.transformedInputs = transformedInputs;
                      this.returnValue = returnValue;
                  },
                  Unimplemented: function () { },
                  Error: function ( e )
                  {
                      this.exception = e;
                  }
                };
               
function runImplementation(implementation, inputs)
{
    if ( implementation !== undefined )
    {
        var clonedInputs = clone(inputs);

        try
        {
            var result = implementation.apply(null, clonedInputs);

            return new runResult.Success( clonedInputs, result );
        }
        catch ( err )
        {
            return new runResult.Error( err );
        }
    }
    else
    {
        return new runResult.Unimplemented();
    }
}

function validateResults(input, expected, received, validator)
{
    if ( received instanceof runResult.Success ) {
        return validator(input, expected, received);
    }
    else
    {
        return false;
    }
}


function extractFunctionName(func) {
    var code = func.toString();
    var pattern = /function (.*?)\(/;
    var matches = pattern.exec(code);
    var result = matches[1];

    return result;
}


var tests = {};

function defineTests(addTestReceiver) {
    function addTest(testedFunction, builderReceiver) {
        if ( !testedFunction )
        {
            throw "Missing function";
        }

        var testUnderConstruction = {
            referenceImplementation: testedFunction,
            inputs: [],
            validator: validators.identical,
            formatter: formatters.simple
        };

        tests[extractFunctionName(testedFunction)] = testUnderConstruction;


        var builder = {
            addInput: function () {
                var copy = Array.prototype.slice.call( arguments, 0 );

                testUnderConstruction['inputs'].push(copy);
            },

            setFormatter: function (formatter) {
                testUnderConstruction.formatter = formatter;
            },

            setValidator: function (validator) {
                testUnderConstruction.validator = validator;
            }
        };

        builderReceiver(builder);
    }

    addTestReceiver(addTest);
}


$(document).ready( function() {
    collectStudentImplementations(tests, window);
    generatePage();
} );

