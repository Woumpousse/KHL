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

function newElement(tag) {
    return $(document.createElement(tag));
}

function createView( contents, extended )
{
    var span = newElement('span');

    span.addClass('viewer');
    span.attr('data-full', extended);
    span.append(contents);

    return span;
}

function newViewer(x) {
    x = stringOf(x);

    if ( x.length > 40 )
    {
        return createView( x.trimLength(40), x );
    }
    else
    {
        return stringOf(x);
    }
}

function allTestCaseSections()
{
    return $('section.testcase');
}

function activeTestCaseSections()
{
    var vars = getUrlVars();

    if ( 'testcase' in vars )
    {
        return $('section.testcase[data-subject={0}]'.format(vars.testcase));
    }
    else
    {
        return allTestCaseSections();
    }
}

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

function generatePage()
{
    function generateTestCaseViews(testData)
    {
        function extractParameterNamesFromFunctionDefinition(code)
        {    
            var pattern = /function .*?\((.*?)\)/;
            var matches = pattern.exec(code);
            var parameterString = matches[1];

            return parameterString.split(/\s*,\s*/);
        }

        function extractFunctionCallSyntaxFromFunctionDefinition(code)
        {
            var pattern = /function (.*?\(.*?\))/;
            var matches = pattern.exec(code);
            var result = matches[1];

            return result;
        }

        function extractParameterNamesFromTestData(testData)
        {
            if ( 'parameters' in testData )
            {
                return testData.parameters;
            }
            else
            {
                return extractParameterNamesFromFunctionDefinition( testData.referenceImplementation.toString() );
            }
        }

        function extractFunctionCallSyntaxFromTestData(testData)
        {
            if ( 'callSyntax' in testData )
            {
                return testData.callSyntax;
            }
            else
            {
                return extractFunctionCallSyntaxFromFunctionDefinition( testData.referenceImplementation.toString() );
            }
        }

        function generateHeaderRow(testData) {
            if ( !testData ) { throw "Missing test data"; }

            function generateParameterHeaderCells()
            {
                var parameterNames = extractParameterNamesFromTestData(testData);

                var parameterCells = _.map( parameterNames, function (parameterName) {
                    var cell = newElement('th');
                    cell.append(parameterName);

                    return cell;
                } );

                var result = parameterCells;
                result.unshift( newElement('td') );

                return result;
            }

            function generateReturnHeader()
            {
                var cell = newElement('th');
                cell.append(extractFunctionCallSyntaxFromTestData(testData));
                return cell;
            }

            var row = newElement('tr');

            row.append( generateParameterHeaderCells() );
            row.append( generateReturnHeader() );

            return row;
        }

        function generateTestCaseBlocks(testData)
        {
            if ( !testData ) { throw "Undefined testdata"; }

            function generateTestCaseBlock(input)
            {
                var expected = runImplementation( testData.referenceImplementation, input );
                var received = runImplementation( testData.implementation, input );
                var correct = validateResults( input, expected, received, testData.validator );

                function formatValue(x)
                {
                    var formatter = testData.formatter;

                    return formatter(x);
                }

                function generateArgumentCells(arguments)
                {
                    return _.map( arguments, function (argument) {
                        var cell = newElement('td');
                        cell.addClass('argument');
                        cell.append( formatValue(argument) );
                        return cell;
                    } );
                }

                function generateResultCell(result)
                {
                    var cell = newElement('td');
                    cell.addClass('result');
                    cell.append( formatValue(result) );
                    return cell;
                }

                function generateOutputRowCells(output)
                {
                    if ( output instanceof runResult.Success )
                    {
                        var result;

                        result = generateArgumentCells(output.transformedInputs);
                        result.push( generateResultCell(output.returnValue) );

                        return result;
                    }
                    else if ( output instanceof runResult.Unimplemented )
                    {
                        var cell = newElement('td');
                        cell.attr('colspan', input.length + 1);
                        cell.addClass('missing-implementation');
                        cell.append("missing implementation");

                        return [ cell ];
                    }
                    else if ( output instanceof runResult.Error )
                    {
                        var cell = newElement('td');
                        cell.attr('colspan', input.length + 1);
                        cell.addClass('error');
                        cell.append( createView( "error", output.exception.toString() ) );

                        return [ cell ];
                    }
                }

                function generateRowCaption(caption)
                {
                    var cell = newElement('td');

                    cell.addClass("block-row-caption");
                    cell.append(caption);

                    return cell;
                }

                function generateHeaderRow()
                {
                    var row = newElement('tr');

                    row.addClass('block-header');
                    row.append( generateRowCaption('Input') );
                    row.append( generateArgumentCells(input) );

                    return row;
                }

                function generateExpectedOutputRow()
                {
                    var row = newElement('tr');

                    row.addClass('block-expected');
                    row.append( generateRowCaption('Expected') );
                    row.append( generateOutputRowCells(expected) );

                    return row;
                }

                function generateReceivedOutputRow()
                {
                    var row = newElement('tr');

                    row.addClass('block-received');
                    row.append( generateRowCaption('Received') );
                    row.append( generateOutputRowCells(received) );

                    return row;
                }

                var rows = [ generateHeaderRow(),
                             generateExpectedOutputRow(),
                             generateReceivedOutputRow()
                           ];

                _.each( rows, function (row) {
                    row.attr('correct', correct ? 'true' : 'false');
                } );

                return rows;
            }

            return _.flatten( _.map( testData.inputs, generateTestCaseBlock ), true );
        }

        function populateTestCaseView(divElement)
        {
            var target = divElement.attr('data-target');
            var myTestData = testData[target];
            var table = newElement('table');
            var tbody = newElement('tbody');

            table.addClass('testcase-table');
            table.append( tbody );
            tbody.append( generateHeaderRow(myTestData) );
            tbody.append( generateTestCaseBlocks(myTestData) );

            divElement.append(table);
        }        

        activeTestCaseSections().each( function () {
            var section = $(this);
            var subject = section.attr('data-subject');

            var div = newElement('div');
            div.addClass('testcase-view');
            div.attr('data-target', subject);

            populateTestCaseView(div);

            section.append(div);
        } );
    }

    function generateHeaders()
    {
        function generateHeader(section)
        {
            var subject = section.attr('data-subject');
            var header = newElement('h2');
            header.append(subject);
            header.attr('id', subject);

            var link = newElement('a');
            link.append("[focus]");
            link.addClass('focus');
            link.attr('href', '?testcase={0}'.format(subject));
            header.append(link);

            section.prepend(header);
        }

        activeTestCaseSections().each( function () {
            generateHeader($(this));
        } );
    }

    function generateNav()
    {
        var list = newElement('ul');
        
        function addNavigation( section )
        {
            var subject = section.attr('data-subject');
            var listItem = newElement('li');
            var link = newElement('a');
            link.append(subject);
            link.attr('href', "#" + subject);
            listItem.append(link);

            list.append(listItem);
            list.append(" ");
        }

        var sections = activeTestCaseSections();

        if ( sections.length > 1 )
        {
            sections.each( function () {
                addNavigation( $(this) );
            } );

            $('nav').append(list);
        }
        else
        {
            var link = newElement('a');
            link.append('[show all]');
            link.attr('href', window.location.href.split("?")[0]);
            $('nav').append(link);
        }
    }

    function showActiveSections()
    {
        activeTestCaseSections().attr('active', 'true');
    }

    showActiveSections();
    generateHeaders();
    generateNav();
    generateTestCaseViews(tests);
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

