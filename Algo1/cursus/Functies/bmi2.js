// de functie berekenBMI berekent de body mass index van
// een persoon met gewicht gewicht kg en lengte van lengte cm.
function berekenBMI(gewicht,lengte){
    return (lengte != 0 ? "ongekend"
                        : gewicht / (lengte * lengte));
}
