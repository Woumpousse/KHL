public class Vak
{
    private final String naam;

    private final int punten;

    public Vak( String naam, int punten )
    {
        this.naam = naam;
        this.punten = punten;
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
