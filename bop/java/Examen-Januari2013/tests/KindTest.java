import static org.junit.Assert.*;

import org.junit.Test;

public class KindTest
{
    private static final String vnaam = "Jan";
    private static final String fnaam = "Janssens";
    private static final Datum gdatum = new Datum( 1, 1, 2014 );

    @Test
    public void methodes()
    {
        ClassChecker checker = new ClassChecker( Kind.class );

        checker.assertPublicMethod( String.class, "getVoornaam" );
        checker.assertPublicMethod( String.class, "getFamilieNaam" );
        checker.assertPublicMethod( Datum.class, "getGeboorteDatum" );
        checker.assertPublicMethod( int.class, "getLeeftijd", Datum.class );

        checker.assertPrivateMethod( void.class, "setVoornaam", String.class );
        checker.assertPrivateMethod( void.class, "setFamilieNaam", String.class );
        checker.assertPrivateMethod( void.class, "setGeboorteDatum", Datum.class );
    }

    @Test
    public void constructor()
    {
        Kind kind = new Kind( vnaam, fnaam, gdatum );

        assertEquals( vnaam, kind.getVoornaam() );
        assertEquals( fnaam, kind.getFamilieNaam() );
        assertEquals( gdatum, kind.getGeboorteDatum() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigeVoornaam()
    {
        new Kind( null, fnaam, gdatum );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigeFamilienaam()
    {
        new Kind( vnaam, null, gdatum );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigeGeboorteDatum()
    {
        new Kind( vnaam, fnaam, null );
    }

    @Test
    public void leeftijd()
    {
        Kind kind = new Kind( vnaam, fnaam, new Datum( 1, 6, 2010 ) );

        assertEquals( 1, kind.getLeeftijd( new Datum( 1, 6, 2011 ) ) );
        assertEquals( 2, kind.getLeeftijd( new Datum( 1, 6, 2012 ) ) );
        assertEquals( 1, kind.getLeeftijd( new Datum( 1, 1, 2012 ) ) );
        assertEquals( 0, kind.getLeeftijd( new Datum( 1, 1, 2011 ) ) );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigeDatum()
    {
        new Kind( vnaam, fnaam, gdatum ).getLeeftijd( null );
    }
}
