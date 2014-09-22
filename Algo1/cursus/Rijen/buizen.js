function berekenAantalBuizen(examenResultaten){
    var aantal= 0;
    for (var i = 0; i < examenResultaten.length; i++){
        if (examenResultaten[i] < 10) {
            aantal++;
        }
    }
    return aantal;
}
