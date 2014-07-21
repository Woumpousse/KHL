public class Vak
{
    private String naam;

    private int punten;

    public Vak( String naam, int punten )
    {
        setNaam(naam);
        setPunten(punten);        
    }
    
    private void setNaam(String naam)
    {
        if ( naam == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.naam = naam;
        }
    }
    
    private void setPunten(int punten)
    {
        if ( punten < 0 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.punten = punten;
        }
    }

    public String getNaam()
    {
        return this.naam;
    }

    public int getPunten()
    {
        return this.punten;
    }
}
