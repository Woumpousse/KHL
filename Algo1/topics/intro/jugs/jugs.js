function parseJugCapacities()
{
    var input = $('#input').val();
    var jugCapacitiesStrings = input.split(/\s*,\s*/);

    return _.map( jugCapacitiesStrings, function (str) {
        return parseInt(str);
    } );
}

function parseGoal()
{
    return parseInt( $('#goal').val() );
}

function newElt(tag)
{
    return $( document.createElement(tag) );
}

function showSolution(solution)
{
    var output = $('#output');
    output.empty();

    var states = [ ["", solution[0].start] ].concat( _.zip( _.map(solution, function (step) { return step.toString(); } ), _.pluck( solution, 'end' ) ) );

    _.each( states, function (pair) {
        var info = pair[0];
        var state = pair[1];
        var row = newElt('tr');

        var infoCell = newElt('td');
        infoCell.append(info.toString());
        row.append(infoCell);

        _.each( state.jugs, function (jug) {
            var td = newElt('td');
            td.append(jug.contents);
            row.append(td);
        } );

        output.append(row);
    } );
}

$('#input').val("2,3,4");
$('#goal').val("1");



$('#go').click( function () {
    var jugCapacities = parseJugCapacities();
    var goal = parseGoal();
    var solution = solve( createInitialState(jugCapacities), goal);

    showSolution(solution);
} );
