import java.util.ArrayList;

public class Dag
{
    public int capaciteit;
    private Datum datum;
    private ArrayList<Inschrijving> inschrijvingen;

    public Dag(Datum datum, int capaciteit)
    {
        setDatum( datum );
        setCapaciteit( capaciteit );

        inschrijvingen = new ArrayList<Inschrijving>();
    }

    private void setCapaciteit(int capaciteit)
    {
        if ( capaciteit < 1 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.capaciteit = capaciteit;
        }
    }

    private void setDatum(Datum datum)
    {
        if ( datum == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.datum = datum;
        }
    }

    public Datum getDatum()
    {
        return datum;
    }

    private int aantalInschrijvingenInVoormiddag()
    {
        int aantal = 0;

        for ( Inschrijving inschrijving : this.inschrijvingen )
        {
            if ( inschrijving.isVoormiddag() )
            {
                ++aantal;
            }
        }

        return aantal;
    }

    private int aantalInschrijvingenInNamiddag()
    {
        int aantal = 0;

        for ( Inschrijving inschrijving : this.inschrijvingen )
        {
            if ( inschrijving.isNamiddag() )
            {
                ++aantal;
            }
        }

        return aantal;
    }

    private boolean plaatsVrijInVoormiddag()
    {
        return aantalInschrijvingenInVoormiddag() < capaciteit;
    }

    private boolean plaatsVrijInNamiddag()
    {
        return aantalInschrijvingenInNamiddag() < capaciteit;
    }

    public boolean plaatsVrijVoor(Inschrijving inschrijving)
    {
        if ( inschrijving == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            if ( inschrijving.isVoormiddag() && !plaatsVrijInVoormiddag() )
            {
                return false;
            }
            else if ( inschrijving.isNamiddag() && !plaatsVrijInNamiddag() )
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }

    private boolean isKindIngeschreven(Kind kind)
    {
        for ( Inschrijving inschrijving : this.inschrijvingen )
        {
            // Hier mag == gebruikt worden
            if ( inschrijving.getKind() == kind )
            {
                return true;
            }
        }
        
        return false;
    }
    
    public void voegInschrijvingToe(Inschrijving inschrijving)
    {
        if ( inschrijving == null || !this.datum.isGelijkAan( inschrijving.getDatum() ) || !plaatsVrijVoor( inschrijving ) || isKindIngeschreven(inschrijving.getKind()) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.inschrijvingen.add( inschrijving );
        }
    }

    public ArrayList<Inschrijving> getInschrijvingen()
    {
        return new ArrayList<Inschrijving>( this.inschrijvingen );
    }
    
    public double kost(Kind kind)
    {
        for ( Inschrijving inschrijving : this.inschrijvingen )
        {
            // Hier mag == gebruikt worden
            if ( inschrijving.getKind() == kind )
            {
                return inschrijving.kostprijs();
            }
        }
        
        return 0;
    }
}
