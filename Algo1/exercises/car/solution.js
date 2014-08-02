// Wijzig de waarde van deze variabele om een andere oefening te selecteren
function drive(car) {
    drive1(car);
}

function drive1(car) {
    forward(car);
}

function drive2(car) {
    forward(car);
    forward(car);
}

function drive3(car) {
    forward(car);
    forward(car);
    forward(car);
}

function drive4(car) {
    for ( var i = 0; i != 4; i = i + 1 ) {
        forward(car);
    }
}

function drive5(car) {
    for ( var i = 0; i != 7; i = i + 1 ) {
        forward(car);
    }
}

function drive6(car) {
    turnRight(car);
    forward(car);
}

function drive7(car) {
    for ( var i = 0; i != 7; i = i + 1 ) {
        forward(car);
    }

    turnRight(car);

    for ( var i = 0; i != 7; i = i + 1 ) {
        forward(car);
    }
}

function drive8(car) {
    for ( var i = 0; i != 7; i = i + 1 ) {
        forward(car);
    }

    turnRight(car);

    for ( var i = 0; i != 7; i = i + 1 ) {
        forward(car);
    }
    
    turnRight(car);

    for ( var i = 0; i != 7; i = i + 1 ) {
        forward(car);
    }
}

function drive9(car) {
    for ( ; !sensor(car); ) {
        forward(car);
    }

    turnRight(car);

    for ( ; !sensor(car); ) {
        forward(car);
    }

    turnRight(car);

    for ( ; !sensor(car); ) {
        forward(car);
    }
}

function drive10(car) {
    while ( !sensor(car) ) {
        forward(car);
    }

    turnRight(car);

    while ( !sensor(car) ) {
        forward(car);
    }

    turnRight(car);

    while ( !sensor(car) ) {
        forward(car);
    }
}

function drive11(car) {
    for ( var i = 0; i != 8; i = i + 1 ) {
        while ( !sensor(car) ) {
            forward(car);
        }

        turnRight(car);
    }
}

function drive12(car) {
    turnRight(car);
    turnRight(car);
    turnRight(car);
    forward(car);
}

function drive13(car) {
    for ( var i = 0; i != 8; i = i + 1 ) {
        while ( !sensor(car) ) {
            forward(car);
        }

        turnRight(car);
        turnRight(car);
        turnRight(car);
    }
}

function turnLeft(car) {
    turnRight(car);
    turnRight(car);
    turnRight(car);    
}

function straightAhead(car) {
    while ( !sensor(car) ) {
        forward(car);
    }
}

function drive14(car) {
    for ( var i = 0; i != 9; i = i + 1 ) {
        straightAhead(car);
        turnLeft(car);
    }
}

function turn(car) {
    turnRight(car);
    turnRight(car);
}

function backward(car) {
    turn(car);
    forward(car);
    turn(car);
}

function drive15(car) {
    backward(car);
}

function backsensor(car) {
    turn(car);
    var result = sensor(car);
    turn(car);
    return result;
}

function fullBackward(car) {
    while ( !backsensor(car) ) {
        backward(car);
    }
}

function drive16(car) {
    fullBackward(car);
}

function fullBackward2(car) {
    turn(car);
    straightAhead(car);
    turn(car);
}

function drive17(car) {
    fullBackward2(car);
}

function leftSensor(car) {
    turnLeft(car);
    var result = sensor(car);
    turnRight(car);
    return result;
}

function rightSensor(car) {
    turnRight(car);
    var result = sensor(car);
    turnLeft(car);
    return result;
}

function drive18(car) {
    straightAhead(car);

    if ( !leftSensor(car) ) {
        turnLeft(car);
    }
    else {
        turnRight(car);
    }

    straightAhead(car);
}

function drive20(car) {
    while ( true ) {
        straightAhead(car);

        if ( !leftSensor(car) ) {
            turnLeft(car);
        }
        else {
            turnRight(car);
        }
    }        
}

function firstLeft(car) {
    while ( leftSensor(car) ) {
        forward(car);
    }
}

function secondLeft(car) {
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
}

function thirdLeft(car) {
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
}


function fourthLeft(car) {
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
    forward(car);
    while ( leftSensor(car) ) {
        forward(car);
    }
}

function nthLeft(car, n) {
  for ( var i = 0; i != n; i = i + 1 ) {
    forward(car);
    while ( leftSensor(car) ) {
      forward(car);
    }
  }
}

function nthRight(car, n) {
  for ( var i = 0; i != n; i = i + 1 ) {
    forward(car);
    while ( rightSensor(car) ) {
      forward(car);
    }
  }
}

function drive22(car) {
    thirdLeft(car);
    turnLeft(car);
    straightAhead(car);
}

function drive23(car) {
    fourthLeft(car);
    turnLeft(car);
    straightAhead(car);
}

function drive24(car) {
    nthLeft(car, 2);
    turnLeft(car);
    straightAhead(car);
}

function drive25(car) {
    nthRight(car, 4);
    turnRight(car);
    straightAhead(car);
}
