function backSensor(car) {
    turn(car);
    var result = sensor(car);
    turn(car);
    return result;
}
