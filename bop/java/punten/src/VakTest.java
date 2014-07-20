import static org.junit.Assert.*;

import org.junit.Test;


public class VakTest
{

    @Test public void aanmaakNieuwVak()
    {
        Vak vak = new Vak( "BOP", 15 );

        assertEquals( "BOP", vak.getNaam() );
        assertEquals( 15, vak.getPunten() );
    }

}
