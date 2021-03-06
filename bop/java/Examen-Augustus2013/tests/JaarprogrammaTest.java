import static org.junit.Assert.*;

import org.junit.*;

public class JaarprogrammaTest
{
    @Test
    public void constructor()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student );

        assertSame( student, jp.getStudent() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_nullStudent()
    {
        new Jaarprogramma( null );
    }

    @Test(expected = IllegalArgumentException.class)
    public void voegInschrijvingToe_nullInschrijving()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student );

        jp.voegInschrijvingToe( null );
    }

    @Test(expected = IllegalArgumentException.class)
    public void voegInschrijvingToe_dubbeleInschrijving()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student );

        OPO opo1 = opo(1, 1);
        OPO opo2 = opo(1, 2);

        jp.voegInschrijvingToe( new Inschrijving( opo1, new Datum( 1, 9, 2013 ) ) );
        jp.voegInschrijvingToe( new Inschrijving( opo2, new Datum( 1, 9, 2013 ) ) );
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void voegInschrijvingToe_teVeelInschrijvingen()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student, 2 );

        OPO opo1 = opo(1, 1);
        OPO opo2 = opo(2, 2);
        OPO opo3 = opo(3, 2);

        jp.voegInschrijvingToe( new Inschrijving( opo1, new Datum( 1, 9, 2013 ) ) );
        jp.voegInschrijvingToe( new Inschrijving( opo2, new Datum( 1, 9, 2013 ) ) );
        jp.voegInschrijvingToe( new Inschrijving( opo3, new Datum( 1, 9, 2013 ) ) );
    }

    @Test
    public void totaalAantalStudiePunten_nulInschrijvingen()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student );

        assertEquals(0, jp.geefTotaalAantalStudiePunten());
    }
    
    @Test
    public void totaalAantalStudiePunten()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student );

        OPO opo1 = opo(1, 1);
        OPO opo2 = opo(2, 2);

        jp.voegInschrijvingToe( new Inschrijving( opo1, new Datum( 1, 9, 2013 ) ) );
        jp.voegInschrijvingToe( new Inschrijving( opo2, new Datum( 1, 9, 2013 ) ) );

        assertEquals(3, jp.geefTotaalAantalStudiePunten());
    }
    
    @Test
    public void inschrijvingsgeld_nulInschrijvingen()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student );

        assertEquals( 65.0, jp.inschrijvingsgeld(), 0.000001);
    }
    
    @Test
    public void inschrijvingsgeld()
    {
        Student student = geldigeStudent();
        Jaarprogramma jp = new Jaarprogramma( student );

        OPO opo1 = opo(1, 1);
        OPO opo2 = opo(2, 2);

        jp.voegInschrijvingToe( new Inschrijving( opo1, new Datum( 1, 9, 2013 ) ) );
        jp.voegInschrijvingToe( new Inschrijving( opo2, new Datum( 1, 9, 2013 ) ) );

        assertEquals( 65 + 8.8 * 3, jp.inschrijvingsgeld(), 0.000001);
    }

    private Student geldigeStudent()
    {
        return new Student( "x", "y", 444444 );
    }
    
    private OPO opo(int id, int studiepunten)
    {
        return new OPO(id, "x", studiepunten);
    }
}
