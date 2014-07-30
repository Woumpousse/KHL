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
    if ( implementation !== undefined )
    {
        var clonedInputs = clone(inputs);
        var result = implementation.apply(null, clonedInputs);

        return { transformedInputs: clonedInputs,
                 returnValue: result
               };
    }
    else
    {
        return undefined;
    }
}

function matchingResults(expected, received)
{
    return _.isEqual(expected, received);
}


function generatePage()
{
    function generateTestCaseViews(testData)
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
            var refImpl = testData.referenceImplementation;
            var impl = testData.implementation;

            function generateTestCaseBlock(input)
            {
                var expected = runImplementation( refImpl, input );
                var received = runImplementation( impl, input );
                var correct = matchingResults(expected, received);

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

                function generateOutputRowCells(output)
                {
                    if ( output !== undefined )
                    {
                        var result;

                        result = generateArgumentCells(output.transformedInputs);
                        result.push( generateResultCell(output.returnValue) );

                        return result;
                    }
                    else
                    {
                        var cell = newElement('td');
                        cell.attr('colspan', input.length + 1);
                        cell.append("Undefined implementation");

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

            table.append( generateHeaderRow(myTestData) );
            table.append( generateTestCaseBlocks(myTestData) );

            divElement.append(table);
        }        

        $('section.testcase').each( function () {
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

            section.prepend(header);
        }

        $('section.testcase').each( function () {
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

        $('section.testcase').each( function () {
            addNavigation( $(this) );
        } );

        $('nav').append(list);
    }

    generateHeaders();
    generateNav();
    generateTestCaseViews(tests);
}

collectStudentImplementations(tests, this);

generatePage();

