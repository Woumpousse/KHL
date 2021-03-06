public class Inschrijving
{
    private OPO opo;

    private Datum datum;

    public Inschrijving(OPO opo, Datum datum)
    {
        setOPO( opo );
        setDatum( datum );
    }

    private void setOPO(OPO opo)
    {
        if ( opo == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.opo = opo;
        }
    }

    private void setDatum(Datum datum)
    {
        if ( !isValidDatum( datum ) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.datum = datum;
        }
    }

    private boolean isValidDatum(Datum datum)
    {
        if ( datum == null )
        {
            return false;
        }
        else
        {
            Datum earliest = new Datum( 1, Datum.SEPTEMBER, datum.getJaar() );
            Datum latest = new Datum( 1, Datum.APRIL, datum.getJaar() );

            return datum.komtNa( earliest ) || datum.komtVoor( latest );
        }
    }

    public OPO getOpo()
    {
        return opo;
    }

    public Datum getDatum()
    {
        return datum;
    }
}
