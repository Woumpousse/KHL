function sqrt(n, precision)
{
    var acc = [];
    var a = 0;
    var b = n;
    var c;

    while ( b - a > precision )
    {
        c = (a + b) / 2;
        acc.push( [a, c, b] );

        if ( c * c > n )
        {
            b = c;
        }
        else
        {
            a = c;
        }
    }

    acc.push( [a, c, b] );
    return acc;
}




String.prototype.format = function () {
    var result = this;
    
    for (var i = 0; i != arguments.length; i++) {
	var regEx = new RegExp("\\{" + i + "\\}", "gm");
	result = result.replace(regEx, arguments[i]);
    }
	
    return result;
};

function newElement(tag)
{
    return $( document.createElement(tag) );
}


function buildTable(input, history)
{
    function createHeaders()
    {
        var row = newElement('tr');

        var headerC = newElement('th');
        headerC.append("x");

        var headerCSqr = newElement('th');
        headerCSqr.append("x * x");

        var headerCR = newElement('th');
        headerCR.append("Evaluation");

        row.append(headerC, headerCSqr, headerCR);

        return row;
    }

    function createRow(historyEntry)
    {
        var row = newElement('tr');
        var c = historyEntry[1];

        var tdc = newElement('td');
        tdc.append(c);

        var tdcsqr = newElement('td');
        tdcsqr.append(c * c);

        var tdr = newElement('td');
        tdr.append( c * c > input ? 'Too high' : 'Too low' );

        row.append( tdc, tdcsqr, tdr );

        return row;
    }

    var output = $('#output');
    output.empty();
    output.append( createHeaders() );

    for ( var i in history )
    {
        var row = createRow(history[i]);
        output.append(row);      
    }    
}

function visualize(input, history)
{
    $('#svg').empty();

    var paper = Raphael('svg', 500, 500);

    function drawLine(pts, color) {
        var path = "M {0} {1}".format(pts[0][0], pts[0][1]);

        for ( var i = 1; i !== pts.length; ++i )
        {
            var pt = pts[i];
            var x = pt[0];
            var y = pt[1];

            path += " L {0} {1}".format(x, y);
        }

        var p = paper.path(path);
        p.attr("stroke", color);
    }

    for ( var i in history )
    {
        var entry = history[i];

        var a = entry[0];
        var c = entry[1];
        var b = entry[2];
        var y = i * 10;

        drawLine( [ [a, y], [b, y] ], '#000000' );
    }

    drawLine( _.zip( _.pluck( history, 1), _.range(0, (history.length - 1) * 10, 10 ) ), '#FF0000' );
}


$('#go').click( function () {
    var input = parseInt( $('#input').val() );
    var history = sqrt( input, 0.01 );

    buildTable(input, history);
    visualize(input, history);
} );
