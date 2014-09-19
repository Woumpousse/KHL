var formatters = ( function () {
    function simple(x)
    {
        return newViewer(x);
    }

    function matrix(x)
    {
        var table = newElement('table');
        var tbody = newElement('tbody');

        table.addClass('matrix');
        table.append(tbody);

        var rows = x.transpose();

        _.each(rows, function (row) {
            var tr = newElement('tr');

            _.each(row, function (item) {
                var td = newElement('td');
                td.append(item);
                tr.append(td);
            });

            tbody.append(tr);
        });

        return table;
    }

    function byType()
    {
        var pairs = arguments;

        return function (x) {
            for ( var i = 0; i !== pairs.length; ++i )
            {
                var pair = pairs[i];
                var predicate = pair[0];
                var formatter = pair[1];

                if ( predicate(x) )
                {
                    return formatter(x);
                }    
            }

            console.log("No formatter found");
        };
    }

    return { simple: simple,
             matrix: matrix,
             byType: byType
           };
} )();

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

    function io(inputComparer, outputComparer)
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

function Test(referenceImplementation)
{
    var me = this;

    this.referenceImplementation = referenceImplementation;
    this.inputs = [];
    this.validator = validators.identical;
    this.formatter = formatters.simple;
    this.setUp = function () { };
}

var tests = {};

function defineTests(addTestReceiver) {
    function extractFunctionName(func) {
        var code = func.toString();
        var pattern = /function (.*?)\(/;
        var matches = pattern.exec(code);
        var result = matches[1];

        return result;
    }

    function addTest(referenceImplementation, builderReceiver) {
        if ( !referenceImplementation )
        {
            throw "Missing function";
        }

        var functionName = extractFunctionName(referenceImplementation);

        // Fill in defaults
        var testUnderConstruction = new Test(referenceImplementation);

        tests[functionName] = testUnderConstruction;

        // Create builder
        var builder = {
            addInput: function () {
                var copy = Array.prototype.slice.call( arguments, 0 );

                testUnderConstruction.inputs.push(copy);
            },

            setFormatter: function (formatter) {
                testUnderConstruction.formatter = formatter;
            },

            setValidator: function (validator) {
                testUnderConstruction.validator = validator;
            },

            setUp: function (func) {
                testUnderConstruction.setUp = func;
            }
        };

        // Collect tests
        builderReceiver(builder);
    }

    addTestReceiver(addTest);
}
