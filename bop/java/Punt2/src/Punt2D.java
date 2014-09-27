/**
 * Een punt2D object komt overeen met een punt in een x,y-assenstelsel met enkel positieve x en y.
 * De x-y as is zo georiënteerd dat de x-as bovenaan horizontaal van links naar rechts en de y-as links verticaal staat van boven naar onder.
 * Je kan een standaard Punt2D object maken overeenkomstig het punt(0,0).
 * Je kan een Punt2D object maken met gegeven x en y coördinaat
 * Je kan de x-coördinaat opvragen. Je kan de y-coördinaat opvragen.
 * Je kan het punt horizontaal bewegen over een afstand.
 * Je kan een punt verticaal bewegen over een afstand.
 * Je kan een punt weergeven in String-vorm in de vorm (x , y)
 * 
 */
public class Punt2D {
    private int x;
    private int y ;
    
    /**
     * Maakt een Punt2D-object met coördinaten (0,0)
     */
    public Punt2D(){

    }
    
    /**
     * Maakt een Punt2D object overeenkomstig (x,y)
     * indien zowel x als y positief, anders wordt er een IllegalArgumentException gegooid
     * 
     * @param x
     *          X-coördinaat
     * @param y
     *          Y-coördinaat
     * @throws IllegalArgumentException wanneer of x of y negatief
     */
    public Punt2D(int x, int y){

    }
    
    /**
     * Geeft de x-coördinaat terug
     * 
     * @return  De x-coördinaat
     */
    public int getX(){
        return this.x;
    }
    
    /**
     * Geeft de y-coördinaat terug
     * 
     * @return  de y-coördinaat
     */
    public int getY(){
        return this.y;
    }
    
    /**
     * Zet de instantievariabele x op nieuwe waarde indien deze nieuwe waarde niet negatief is
     * Gooit een IllegalArgumentException indien x negatief is.
     * Exceptions opwerpen doe je met "throw new DeExceptionKlasse();"
     * 
     * @param x
     *          De nieuwe waarde voor de instantievariabele x
     * @throws IllegalArgumentException
     *          Opgeworpen iindien x negatief is
     */
    private  setX( ){
         
    }
    
    /**
     * Zet de instantievariabele y op nieuwe waarde indien deze nieuwe waarde niet negatief is
     * Gooit een IllegalArgumentException anders
     * 
     * @param x
     *          De nieuwe waarde voor de instantievariabele y
     * @throws IllegalArgumentException
     *          Opgeworpen indien y negatief is
     */
    private   setY( ){
         
    }
    
    /**
     * Verschuift het punt horizontaal over een afstand indien mogelijk
     * Gooit een IllegalArgumentException anders
     * 
     * @param afstand
     *          Afstand waarover het punt horizontaal moet verschuiven
     * @throws IllegalArgumeException
     *              Opgeworpen indien het punt2D object niet over deze afstand 
     *              horizontaal kan verschuiven
     */
    public   moveHorizontally( ){
         
    }
    
    /**
     * Verschuift het punt vertikaal over een afstand indien mogelijk
     * Gooit een IllegalArgumentException anders 
     * 
     * @param afstand
     *          Afstand waarover het punt verticaal moet verschuiven
     * @throws IllegalArgumeException
     *          indien het punt2D object niet over deze afstand 
     *          verticaal kan verschuiven
     */
    public   moveVertically( ){
         
    }
    
    /**
     * geeft het punt terug in String-vorm voorbeeld "(5 , 6)"
     * @return de String-vorm
     */
    public String toString(){
        return "(" + this.getX() + " , " + this.getY() + ")";
    }
}
