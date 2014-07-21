import static org.junit.Assert.*;

import org.junit.Test;


public class VakTest
{
    @Test public void constructor()
    {
        Vak vak = new Vak( "BOP", 15 );

        assertEquals( "BOP", vak.getNaam() );
        assertEquals( 15, vak.getPunten() );
    }
    
    @Test(expected=IllegalArgumentException.class) public void constructor_ongeldigeNaam()
    {
        new Vak(null, 1);
    }
    
    @Test(expected=IllegalArgumentException.class) public void constructor_ongeldigePunten()
    {
        new Vak("BOP", -1);
    }
}
