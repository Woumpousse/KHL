import static org.junit.Assert.*;

import org.junit.*;


public class VerblijfTest
{
    @Test(expected=IllegalArgumentException.class)
    public void ongeldigeInschrijving()
    {
        Verblijf verblijf = new Verblijf();
        
        verblijf.schrijfIn( null );
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void dubbeleInschrijving()
    {
        Verblijf verblijf = new Verblijf();
        Kind kind = new Kind("Jef", "Jefferson", new Datum(1,1,2000));
        
        Inschrijving inschrijving1 = new Inschrijving( kind, new Datum(1,1,2001), true, false);
        verblijf.schrijfIn( inschrijving1 );
        
        Inschrijving inschrijving2 = new Inschrijving( kind, new Datum(1,1,2001), true, false);
        verblijf.schrijfIn( inschrijving2 );        
    }
    
    @Test
    public void kostMetEenInschrijving()
    {
        Verblijf verblijf = new Verblijf();
        Kind kind = new Kind("Jef", "Jefferson", new Datum(1,1,2000));

        Inschrijving inschrijving = new Inschrijving( kind, new Datum(1,1,2001), true, false);
        verblijf.schrijfIn( inschrijving );
        
        assertEquals(29.95, verblijf.kost( kind ), 0.01);
    }

    @Test
    public void kostMetDrieInschrijvingen()
    {
        Verblijf verblijf = new Verblijf();
        Kind kind = new Kind("Jef", "Jefferson", new Datum(1,1,2000));
        
        Inschrijving inschrijving1 = new Inschrijving( kind, new Datum(1,1,2001), true, true );
        verblijf.schrijfIn( inschrijving1 );
        
        Inschrijving inschrijving2 = new Inschrijving( kind, new Datum(2,1,2001), true, true );
        verblijf.schrijfIn( inschrijving2 );
        
        Inschrijving inschrijving3 = new Inschrijving( kind, new Datum(3,1,2001), true, true );
        verblijf.schrijfIn( inschrijving3 );
        
        assertEquals(3 * 49.95, verblijf.kost( kind ), 0.01);
    }
    
    @Test
    public void kostMetNulInschrijvingen()
    {
        Verblijf verblijf = new Verblijf();
        Kind kind = new Kind("Jef", "Jefferson", new Datum(1,1,2000));

        assertEquals(0, verblijf.kost( kind ), 0.01);
    }

    
    @Test(expected=IllegalArgumentException.class)
    public void kostOngeldigKind()
    {
        Verblijf verblijf = new Verblijf();
        verblijf.kost( null );
    }
}
