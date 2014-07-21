import static org.junit.Assert.*;

import org.junit.*;

public class DagTest
{
    private final Datum datum = new Datum( 1, 1, 2001 );

    @Test
    public void methodes()
    {
        ClassChecker checker = new ClassChecker( Dag.class );

        checker.assertPublicMethod( Datum.class, "getDatum" );
        checker.assertPublicMethod( void.class, "voegInschrijvingToe", Inschrijving.class );
        checker.assertPublicMethod( double.class, "kost", Kind.class );

        checker.assertPrivateMethod( void.class, "setDatum", Datum.class );
    }
    
    @Test
    public void constructor()
    {
        Dag dag = new Dag( datum, 2 );

        assertTrue( datum.isGelijkAan( dag.getDatum() ) );
        assertEquals( 0, dag.getInschrijvingen().size() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigeDatum()
    {
        new Dag( null, 2 );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructor_ongeldigMaximum()
    {
        new Dag( datum, -1 );
    }

    @Test
    public void toevoegenInschrijving1()
    {
        Dag dag = dag();
        Inschrijving inschrijving = inschrijving( true, true );
        dag.voegInschrijvingToe( inschrijving );

        assertEquals( 1, dag.getInschrijvingen().size() );
        assertSame( inschrijving, dag.getInschrijvingen().get( 0 ) );
    }

    public void toevoegenInschrijving2()
    {
        Dag dag = dag();
        dag.voegInschrijvingToe( inschrijving( true, false ) );
        dag.voegInschrijvingToe( inschrijving( false, true ) );

        assertEquals( 2, dag.getInschrijvingen().size() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void toevoegenInschrijvingZonderPlaats1()
    {
        Dag dag = dag( 1 );
        dag.voegInschrijvingToe( inschrijving( true, true ) );
        dag.voegInschrijvingToe( inschrijving( true, true ) );
    }

    @Test(expected = IllegalArgumentException.class)
    public void toevoegenInschrijvingZonderPlaats2()
    {
        Dag dag = dag( 1 );
        dag.voegInschrijvingToe( inschrijving( true, false ) );
        dag.voegInschrijvingToe( inschrijving( true, true ) );
    }

    @Test(expected = IllegalArgumentException.class)
    public void toevoegenInschrijvingZonderPlaats3()
    {
        Dag dag = dag( 1 );
        dag.voegInschrijvingToe( inschrijving( false, true ) );
        dag.voegInschrijvingToe( inschrijving( true, true ) );
    }

    @Test(expected = IllegalArgumentException.class)
    public void toevoegenInschrijvingOpFouteDag()
    {
        Dag dag = new Dag( new Datum( 1, 1, 2001 ), 2 );
        Inschrijving inschrijving = new Inschrijving( kind(), new Datum( 2, 1, 2001 ), true, true );
        dag.voegInschrijvingToe( inschrijving );
    }

    @Test(expected = IllegalArgumentException.class)
    public void toevoegenInschrijvingZelfdeKind()
    {
        Dag dag = new Dag( new Datum( 1, 1, 2001 ), 2 );
        Kind kind = kind();

        Inschrijving inschrijving1 = new Inschrijving( kind, new Datum( 2, 1, 2001 ), true, true );
        dag.voegInschrijvingToe( inschrijving1 );

        Inschrijving inschrijving2 = new Inschrijving( kind, new Datum( 2, 1, 2001 ), true, true );
        dag.voegInschrijvingToe( inschrijving2 );
    }

    private Dag dag(int max)
    {
        return new Dag( datum, max );
    }

    private Dag dag()
    {
        return dag( 2 );
    }

    private Kind kind()
    {
        return new Kind( "Willem", "Willems", new Datum( 1, 1, 2000 ) );
    }

    private Inschrijving inschrijving(boolean voormiddag, boolean namiddag)
    {
        return new Inschrijving( kind(), datum, voormiddag, namiddag );
    }
}
