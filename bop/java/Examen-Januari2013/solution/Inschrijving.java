public class Inschrijving
{
    private Kind kind;
    private boolean voormiddag;
    private boolean namiddag;
    private Datum datum;

    public Inschrijving(Kind kind, Datum datum, boolean voormiddag, boolean namiddag)
    {
        setDatum(datum);
        setKind( kind );
        setHalveDagen( voormiddag, namiddag );
    }

    private void setKind(Kind kind)
    {
        if ( kind == null || kind.getLeeftijd(datum) > 3 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.kind = kind;
        }
    }

    private void setDatum(Datum datum)
    {
        if ( datum == null || datum.dagVanDeWeek() == Datum.ZATERDAG || datum.dagVanDeWeek() == Datum.ZONDAG )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.datum = datum;
        }
    }
    
    private void setHalveDagen(boolean voormiddag, boolean namiddag)
    {
        if ( !(voormiddag || namiddag) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.voormiddag = voormiddag;
            this.namiddag = namiddag;
        }
    }

    public Kind getKind()
    {
        return kind;
    }

    public boolean isVoormiddag()
    {
        return voormiddag;
    }

    public boolean isNamiddag()
    {
        return namiddag;
    }

    public Datum getDatum()
    {
        return datum;
    }
    
    public double kostprijs()
    {
        if ( voormiddag && namiddag )
        {
            return 49.95;
        }
        else
        {
            return 29.95;
        }
    }
}
