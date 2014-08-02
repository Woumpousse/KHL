var exercise = 26;

function drive(car)
{
    var visited = [];
    var currentPosition = Vector2D(0, 0);

    function visit(p) {
        visited.push(p);
    }

    function isVisited(p) {
        return visited.some( function (q) { return p.eq(q); } );
    }

    function forward() {
        car.forward();
    }

    function turnRight() {
        car.turnRight();
    }

    function turnLeft() {
        turnRight();
        turnRight();
        turnRight();
    }

    function turn() {
        turnRight();
        turnRight();
    }

    function stepForward() {
        forward();
        currentPosition = currentPosition.add( Vector2D(0, 1) );
    }

    function stepRight() {
        turnRight();
        forward();
        turnLeft();
        currentPosition = currentPosition.add( Vector2D(1, 0) );
    }

    function stepLeft() {
        turnLeft();
        forward();
        turnRight();
        currentPosition = currentPosition.add( Vector2D(-1, 0) );
    }

    function stepBack() {
        turn();
        forward();
        turn();
        currentPosition = currentPosition.add( Vector2D(0, -1) );
    }

    function sensorFront() {
        return car.sensor();
    }

    function sensorLeft() {
        turnLeft();
        var result = sensorFront();
        turnRight();
        return result;
    }

    function sensorRight() {
        turnRight();
        var result = sensorFront();
        turnLeft();
        return result;
    }

    function sensorBack() {
        turn();
        var result = sensorFront();
        turn();
        return result;
    }

    function solve() {
        if ( !isVisited(currentPosition) ) {
            visit(currentPosition);
         
            if ( !sensorLeft() ) {
                stepLeft();
                solve();
                stepRight();
            }
            if ( !sensorFront() ) {
                stepForward();
                solve();
                stepBack();
            }
            if ( !sensorRight() ) {
                stepRight();
                solve();
                stepLeft();
            }
            if ( !sensorBack() ) {
                stepBack();
                solve();
                stepForward();
            }
        }
    }

    solve();
}
