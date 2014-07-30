function newElement(tag) {
    return $(document.createElement(tag));
}

function newViewer(x) {
    x = stringOf(x);

    if ( x.length > 40 ) {
        var span = newElement('span');
        span.append(x.trimLength(40));
        span.addClass('viewer');
        span.attr('data-full', x);
        return span;
    }
    else {
        return stringOf(x);
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

function runImplementation(implementation, inputs)
{
    var clonedInputs = clone(inputs);
    var result = implementation.apply(null, clonedInputs);

    return { transformedInputs: clonedInputs,
             returnValue: result
           };
}

function populateTestCaseViews(testData)
{
    function extractParameterNamesFromFunctionDefinition(code)
    {    
        var pattern = /function .*?\((.*?)\)/g;
        var matches = pattern.exec(code);
        var parameterString = matches[1];

        return parameterString.split(/\s*,\s*/);
    }

    function extractFunctionCallSyntaxFromFunctionDefinition(code)
    {
        var pattern = /function (.*?\(.*?\))/g;
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
        function generateParameterHeaderCells()
        {
            var parameterNames = extractParameterNamesFromTestData(testData);
            
            return _.map( parameterNames, function (parameterName) {
                var cell = newElement('th');
                cell.append(parameterName);
                
                return cell;
            } );
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
        var refImpl = testData.referenceImplementation;
        var impl = testData.implementation;

        function generateArgumentCells(arguments)
        {
            return _.map( arguments, function (argument) {
                var cell = newElement('td');
                cell.addClass('argument');
                cell.append(argument.toString());
                return cell;
            } );
        }

        function generateResultCell(result)
        {
            var cell = newElement('td');
            cell.addClass('result');
            cell.append( newViewer(result) );
            return cell;
        }

        function generateTestCaseBlock(input)
        {
            function generateBlockHeaderRow()
            {
                var row = newElement('tr');
                row.addClass('block-header');

                row.append( generateArgumentCells(input) );

                return row;
            }

            function generateBlockOutputRow(implementation)
            {
                var row = newElement('tr');

                if ( implementation !== undefined )
                {
                    var output = runImplementation( implementation, input );

                    row.append( generateArgumentCells(output.transformedInputs) );
                    row.append( generateResultCell(output.returnValue) );

                    return row;
                }
                else
                {
                    var cell = newElement('td');
                    cell.attr('colspan', input.length + 1);
                    cell.append("Undefined implementation");

                    row.append(cell);

                    return row;
                }
            }

            function generateBlockReferenceOutputRow()
            {
                return generateBlockOutputRow(refImpl);
            }

            function generateBlockReceivedOutputRow()
            {
                return generateBlockOutputRow(impl);
            }

            return [ generateBlockHeaderRow(),
                     generateBlockReferenceOutputRow(),
                     generateBlockReceivedOutputRow()
                   ];
        }

        return _.flatten( _.map( testData.inputs, generateTestCaseBlock ), true );
    }

    function populateTestCaseView(divElement)
    {
        var target = divElement.attr('data-target');
        var myTestData = testData[target];
        var table = newElement('table');

        table.append( generateHeaderRow(myTestData) );
        table.append( generateTestCaseBlocks(myTestData) );
        
        divElement.append(table);
    }

    $('.test-case-view').each( function (index) {
        var element = $(this);
        
        populateTestCaseView( element );
    } );
}

function isOdd(x) { return x % 2 == 1; }

collectStudentImplementations(tests, this);
populateTestCaseViews(tests);
