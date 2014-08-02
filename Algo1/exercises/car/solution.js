// Wijzig de waarde van deze variabele om een andere oefening te selecteren
function drive(car) {
    drive1(car);
}

function drive1(car) {
    car.forward();
}

function drive2(car) {
    car.forward();
    car.forward();
}

function drive3(car) {
    car.forward();
    car.forward();
    car.forward();
}

function drive4(car) {
    for ( var i = 0; i != 4; i = i + 1 ) {
        car.forward();
    }
}

function drive5(car) {
    for ( var i = 0; i != 7; i = i + 1 ) {
        car.forward();
    }
}

function drive6(car) {
    car.turnRight();
    car.forward();
}

function drive7(car) {
    for ( var i = 0; i != 7; i = i + 1 ) {
        car.forward();
    }

    car.turnRight();

    for ( var i = 0; i != 7; i = i + 1 ) {
        car.forward();
    }
}

function drive8(car) {
    for ( var i = 0; i != 7; i = i + 1 ) {
        car.forward();
    }

    car.turnRight();

    for ( var i = 0; i != 7; i = i + 1 ) {
        car.forward();
    }
    
    car.turnRight();

    for ( var i = 0; i != 7; i = i + 1 ) {
        car.forward();
    }
}

function drive9(car) {
    for ( ; !car.sensor(); ) {
        car.forward();
    }

    car.turnRight();

    for ( ; !car.sensor(); ) {
        car.forward();
    }

    car.turnRight();

    for ( ; !car.sensor(); ) {
        car.forward();
    }
}

function drive10(car) {
    while ( !car.sensor() ) {
        car.forward();
    }

    car.turnRight();

    while ( !car.sensor() ) {
        car.forward();
    }

    car.turnRight();

    while ( !car.sensor() ) {
        car.forward();
    }
}

function drive11(car) {
    for ( var i = 0; i != 8; i = i + 1 ) {
        while ( !car.sensor() ) {
            car.forward();
        }

        car.turnRight();
    }
}

function drive12(car) {
    car.turnRight();
    car.turnRight();
    car.turnRight();
    car.forward();
}

function drive13(car) {
    for ( var i = 0; i != 8; i = i + 1 ) {
        while ( !car.sensor() ) {
            car.forward();
        }

        car.turnRight();
        car.turnRight();
        car.turnRight();
    }
}

function turnLeft(car) {
    car.turnRight();
    car.turnRight();
    car.turnRight();    
}

function straightAhead(car) {
    while ( !car.sensor() ) {
        car.forward();
    }
}

function drive14(car) {
    for ( var i = 0; i != 9; i = i + 1 ) {
        straightAhead(car);
        turnLeft(car);
    }
}

function turn(car) {
    car.turnRight();
    car.turnRight();
}

function backward(car) {
    turn(car);
    car.forward();
    turn(car);
}

function drive15(car) {
    backward(car);
}

function backsensor(car) {
    turn(car);
    var result = car.sensor();
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
    var result = car.sensor();
    car.turnRight();
    return result;
}

function rightSensor(car) {
    car.turnRight();
    var result = car.sensor();
    turnLeft(car);
    return result;
}

function drive18(car) {
    straightAhead(car);

    if ( !leftSensor(car) ) {
        turnLeft(car);
    }
    else {
        car.turnRight();
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
            car.turnRight();
        }
    }        
}

function firstLeft(car) {
    while ( leftSensor(car) ) {
        car.forward();
    }
}

function secondLeft(car) {
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
}

function thirdLeft(car) {
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
}


function fourthLeft(car) {
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
    car.forward();
    while ( leftSensor(car) ) {
        car.forward();
    }
}

function nthLeft(car, n) {
  for ( var i = 0; i != n; i = i + 1 ) {
    car.forward();
    while ( leftSensor(car) ) {
      car.forward();
    }
  }
}

function nthRight(car, n) {
  for ( var i = 0; i != n; i = i + 1 ) {
    car.forward();
    while ( rightSensor(car) ) {
      car.forward();
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
    car.turnRight();
    straightAhead(car);
}
