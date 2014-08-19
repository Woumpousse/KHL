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
                        console.log(output);

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

$(document).ready( function() {
    collectStudentImplementations(tests, window);
    generatePage();
} );
