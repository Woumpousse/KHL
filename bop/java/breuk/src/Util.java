public class Util
{
    /*
     * Deze methode roep je op als volgt:
     * 
     * int resultaat = Util.ggd( x, y );
     */
    public static int ggd(int x, int y)
    {
        x = Math.abs( x );
        y = Math.abs( y );

        while ( y != 0 )
        {
            if ( x < y )
            {
                int temp = x;
                x = y;
                y = temp;
            }
            else
            {
                x %= y;
            }
        }

        return x;
    }
}
