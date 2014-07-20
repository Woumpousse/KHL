public class Util
{
    /*
     * Deze methode roep je op als volgt:
     * 
     * int resultaat = Util.ggd( x, y );
     */
    public static int ggd(int x, int y)
    {
        if ( y == 0 )
        {
            return x;
        }
        else if ( x < y )
        {
            return ggd( y, x );
        }
        else
        {
            return ggd( y, x % y );
        }
    }
}
