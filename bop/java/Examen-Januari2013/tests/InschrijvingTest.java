import static org.junit.Assert.*;

import org.junit.*;

public class InschrijvingTest
{
    private final Datum datum = new Datum( 1, 1, 2001 );

    @Test
    public void methodes()
    {
        ClassChecker checker = new ClassChecker( Inschrijving.class );

        checker.assertPublicMethod( Kind.class, "getKind" );
        checker.assertPublicMethod( Datum.class, "getDatum" );
        checker.assertPublicMethod( boolean.class, "isVoormiddag" );
        checker.assertPublicMethod( boolean.class, "isVoormiddag" );
        checker.assertPublicMethod( double.class, "kostprijs" );

        checker.assertPrivateMethod( void.class, "setKind", Kind.class );
        checker.assertPrivateMethod( void.class, "setDatum", Datum.class );
    }
    
    @Test
    public void constructor()
    {
        Kind kind = kind();
        Inschrijving inschrijving = new Inschrijving( kind, datum, true, true );

        assertSame( kind, inschrijving.getKind() );
        assertTrue( datum.isGelijkAan( inschrijving.getDatum() ) );
        assertTrue( inschrijving.isVoormiddag() );
        assertTrue( inschrijving.isNamiddag() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigKind()
    {
        new Inschrijving( null, datum, true, true );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigeDatum()
    {
        new Inschrijving( kind(), null, true, true );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigeHalveDagen()
    {
        new Inschrijving( null, datum, false, false );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_kindTeOud()
    {
        new Inschrijving( kind( new Datum( 1, 1, 2000 ) ), new Datum( 1, 1, 2010 ), false, false );
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructor_opZaterdag()
    {
        Datum datum = new Datum( 19, 7, 2014 );
        assertEquals(Datum.ZATERDAG, datum.dagVanDeWeek());
        
        new Inschrijving( kind( new Datum( 1, 1, 2000 ) ), datum, false, false );
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructor_opZondag()
    {
        Datum datum = new Datum( 20, 7, 2014 );
        assertEquals(Datum.ZONDAG, datum.dagVanDeWeek());
        
        new Inschrijving( kind( new Datum( 1, 1, 2000 ) ), datum, false, false );
    }

    @Test
    public void kostprijsEnkelNamiddag()
    {
        Inschrijving inschrijving = new Inschrijving( kind(), datum, false, true );
        
        assertEquals(29.95, inschrijving.kostprijs(), 0.01);
    }
    
    @Test
    public void kostprijsEnkelVoormiddag()
    {
        Inschrijving inschrijving = new Inschrijving( kind(), datum, true, false);
        
        assertEquals(29.95, inschrijving.kostprijs(), 0.01);
    }

    @Test
    public void kostprijsGanseDag()
    {
        Inschrijving inschrijving = new Inschrijving( kind(), datum, true, true);
        
        assertEquals(49.95, inschrijving.kostprijs(), 0.01);
    }

    private Kind kind()
    {
        return kind( new Datum( 1, 1, 2000 ) );
    }

    private Kind kind(Datum geboorteDatum)
    {
        return new Kind( "Peter", "Peters", geboorteDatum );
    }
}
