import static org.junit.Assert.*;

import org.junit.Test;

public class StudentTest
{
    private static final String ALGO = "algo";
    private static final String BOP = "BOP";
    private static final String WISKUNDE = "wiskunde";
    
    @Test public void aanmaakNieuweStudent()
    {
        Student student = new Student( "Jan" );

        assertEquals( "Jan", student.getNaam() );
        assertEquals( 0, student.aantalVakken() );
    }

    @Test public void tellenAantalVakken()
    {
        Student student = new Student( "Jan" );

        assertEquals( 0, student.aantalVakken() );

        student.voegPuntenToe( new Vak( WISKUNDE, 11 ) );
        assertEquals( 1, student.aantalVakken() );

        student.voegPuntenToe( new Vak( BOP, 15 ) );
        assertEquals( 2, student.aantalVakken() );
    }

    @Test(expected=RuntimeException.class) public void toevoegenPuntenReedsBestaandVak()
    {
        Student student = new Student( "Jan" );

        assertEquals( 0, student.aantalVakken() );
        student.voegPuntenToe( new Vak( ALGO, 15 ) );
        student.voegPuntenToe( new Vak( ALGO, 15 ) );        
    }

    @Test public void opvragenPunten()
    {
        Student student = new Student( "Jan" );
        student.voegPuntenToe( new Vak( ALGO, 19 ) );

        Vak vak = student.vindVak( ALGO );

        assertNotNull( vak );
        assertEquals( ALGO, vak.getNaam() );
        assertEquals( 19, vak.getPunten() );
    }

    @Test(expected=RuntimeException.class) public void opvragenPuntenOnbekendVak()
    {
        Student student = new Student( "Jan" );
        student.voegPuntenToe( new Vak( ALGO, 19 ) );

        student.vindVak( "Algo2" );
    }

    @Test public void opvragenVakOpIndex()
    {
        Student student = new Student( "Jan" );
        Vak algo = new Vak( ALGO, 17 );
        Vak bop = new Vak( BOP, 16 );

        student.voegPuntenToe( algo );
        student.voegPuntenToe( bop );

        assertSame( algo, student.vindVak( 0 ) );
        assertSame( bop, student.vindVak( 1 ) );
    }

    @Test(expected=RuntimeException.class) public void opvragenVakMetOngeldigeIndex()
    {
        Student student = new Student( "Jan" );
        Vak algo = new Vak( ALGO, 17 );
        Vak bop = new Vak( BOP, 16 );

        student.voegPuntenToe( algo );
        student.voegPuntenToe( bop );

        student.vindVak( -1 );
    }

    @Test public void opvragenTotaal()
    {
        Student student = new Student( "Jan" );

        student.voegPuntenToe( new Vak( ALGO, 19 ) );
        assertEquals( 95.0, student.totaal(), 0.1 );

        student.voegPuntenToe( new Vak( BOP, 17 ) );
        assertEquals( 90.0, student.totaal(), 0.1 );
    }

    @Test public void opvragenGemiddelde()
    {
        Klas klas = new Klas( 5 );
        Student jan = new Student( "Jan" );
        Student piet = new Student( "Piet" );
        Student jef = new Student( "Jef" );
        klas.voegStudentToe( jan );
        klas.voegStudentToe( piet );
        klas.voegStudentToe( jef );

        jan.voegPuntenToe( new Vak( ALGO, 14 ) );
        assertEquals( 14.0, klas.gemiddelde( ALGO ), 0.1 );

        jan.voegPuntenToe( new Vak( BOP, 16 ) );
        assertEquals( 14.0, klas.gemiddelde( ALGO), 0.1 );
        assertEquals( 16.0, klas.gemiddelde( BOP ), 0.1 );

        piet.voegPuntenToe( new Vak( ALGO, 18 ) );
        assertEquals( 16.0, klas.gemiddelde( ALGO), 0.1 );
        assertEquals( 16.0, klas.gemiddelde( BOP ), 0.1 );
    }
    
    @Test public void volgtVak()
    {
        Student jan = new Student("Jan");
        jan.voegPuntenToe( new Vak(ALGO, 14 ) );
    }
}
