function nthLeft(car, n) {
  for ( var i = 0; i != n; i = i + 1 ) {
    car.forward();
    while ( !leftSensor(car) ) {
      car.forward();
    }
  }
}
