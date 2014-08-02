function nthLeft(car, n) {
  for ( var i = 0; i != n; i = i + 1 ) {
    forward(car);
    while ( !leftSensor(car) ) {
      forward(car);
    }
  }
}
