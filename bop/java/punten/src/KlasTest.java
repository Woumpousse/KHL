import static org.junit.Assert.*;

import org.junit.Test;


public class KlasTest
{
    @Test(expected=RuntimeException.class) public void aanmaakKlasMetNegatieveCapaciteit_WerptException()
    {
        new Klas( -1 );
    }
    
    @Test public void maakLegeKlas()
    {
        Klas klas = new Klas( 10 );

        assertEquals( 10, klas.capaciteit() );
    }
    
    @Test public void maakLegeKlasMetStandaardCapaciteit()
    {
        Klas klas = new Klas();

        assertEquals( 30, klas.capaciteit() );
    }
    
    @Test public void opvragenStudentenVanLegeKlas()
    {
        Klas klas = new Klas( 10 );
        String[] namen = klas.studentenLijst();

        assertEquals( 0, namen.length );
    }
    
    @Test public void toevoegenStudent()
    {
        Klas klas = new Klas( 10 );
        klas.voegStudentToe( new Student( "Jan" ) );
        String[] namen = klas.studentenLijst();

        assertEquals( 1, namen.length );
        assertEquals( "Jan", namen[0] );
    }
    
    @Test(expected=RuntimeException.class) public void toevoegenStudentAanVolleKlasGeeftFout()
    {
        Klas klas = new Klas( 2 );

        klas.voegStudentToe( new Student( "Jan" ) );
        klas.voegStudentToe( new Student( "Piet" ));
        klas.voegStudentToe( new Student( "Jef" ));
    }

    @Test(expected=RuntimeException.class) public void toevoegenStudentMetZelfdeNaamGeeftFout()
    {
        Klas klas = new Klas( 5 );

        klas.voegStudentToe( new Student( "Jan" ) );
        klas.voegStudentToe( new Student( "Piet" ) );
        klas.voegStudentToe( new Student( "Jan" ) );
    }
    
    @Test public void aantalStudentenTellenInKlas()
    {
        Klas klas = new Klas( 5 );
        Student jan = new Student( "Jan" );
        Student piet = new Student( "Piet" );
        Student jef = new Student( "Jef" );

        assertEquals( 0, klas.aantalStudenten() );

        klas.voegStudentToe( jan );

        assertEquals( 1, klas.aantalStudenten() );

        klas.voegStudentToe( piet );

        assertEquals( 2, klas.aantalStudenten() );

        klas.voegStudentToe( jef );

        assertEquals( 3, klas.aantalStudenten() );
    }

    @Test public void aantalVrijePlaatsenTellenInKlas()
    {
        Klas klas = new Klas( 5 );
        Student jan = new Student( "Jan" );
        Student piet = new Student( "Piet" );
        Student jef = new Student( "Jef" );

        assertEquals( 5, klas.aantalVrijePlaatsen() );

        klas.voegStudentToe( jan );

        assertEquals( 4, klas.aantalVrijePlaatsen() );

        klas.voegStudentToe( piet );

        assertEquals( 3, klas.aantalVrijePlaatsen() );

        klas.voegStudentToe( jef );

        assertEquals( 2, klas.aantalVrijePlaatsen() );
    }
}
