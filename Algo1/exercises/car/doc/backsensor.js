function backSensor(car) {
    turn(car);
    var result = car.sensor();
    turn(car);
    return result;
}
