import java.util.ArrayList;

public class Verblijf
{
    private ArrayList<Dag> agenda;

    public Verblijf()
    {
        agenda = new ArrayList<Dag>();
    }

    private Dag vindDag(Datum datum)
    {
        if ( datum == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            for ( Dag dag : agenda )
            {
                if ( dag.getDatum().isGelijkAan( datum ) )
                {
                    return dag;
                }
            }

            Dag dag = new Dag( datum, 7 );
            agenda.add( dag );

            return dag;
        }
    }

    public void schrijfIn(Inschrijving inschrijving)
    {
        if ( inschrijving == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            Dag dag = vindDag( inschrijving.getDatum() );
            dag.voegInschrijvingToe( inschrijving );
        }
    }

    public double kost(Kind kind)
    {
        if ( kind == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            double totaal = 0;

            for ( Dag dag : agenda )
            {
                totaal += dag.kost( kind );
            }

            return totaal;
        }
    }
}
