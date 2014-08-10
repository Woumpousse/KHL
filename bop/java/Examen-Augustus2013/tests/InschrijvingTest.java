import static org.junit.Assert.*;

import org.junit.*;

public class InschrijvingTest
{
    @Test
    public void constructor()
    {
        OPO opo = geldigeOPO();
        Datum datum = new Datum( 1, 9, 2013 );
        Inschrijving inschrijving = new Inschrijving( opo, datum );

        assertSame( opo, inschrijving.getOpo() );
        assertEquals( datum, inschrijving.getDatum() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_nullOPO()
    {
        OPO opo = null;
        Datum datum = new Datum( 1, 9, 2013 );
        new Inschrijving( opo, datum );
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructor_nullDatum()
    {
        OPO opo = geldigeOPO();
        Datum datum = null;
        new Inschrijving( opo, datum );
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructor_teVroeg()
    {
        OPO opo = geldigeOPO();
        Datum datum = new Datum( 31, 8, 2013 );
        new Inschrijving( opo, datum );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_teLaat()
    {
        OPO opo = geldigeOPO();
        Datum datum = new Datum( 2, 4, 2013 );
        new Inschrijving( opo, datum );
    }

    private OPO geldigeOPO()
    {
        return new OPO( 1, "x", 1 );
    }
}
