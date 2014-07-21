
public class MeerkeuzeVraag
{
    /* Velden */
    private String vraagstelling;
    private String[] antwoorden;
    private int correctAntwoord;
    
    /* Constructor */
    public MeerkeuzeVraag(String vraagstelling, String[] antwoorden, int correctAntwoord)
    {
        setVraagstelling(vraagstelling);
        setAntwoorden(antwoorden, correctAntwoord);
    }
    
    /* Setter voor vraag */
    private void setVraagstelling(String vraagstelling)
    {
        if ( vraagstelling == null ){
            throw new IllegalArgumentException();
        }
        else
        {
            this.vraagstelling = vraagstelling;
        }
    }
    
    /*
     * Setter voor antwoorden en correctAntwoord
     * 
     * Als we ooit de antwoorden wijzigen, moet correctAntwoord gecheckt worden, en vice versa.
     * We kiezen daarvoor om een enkele setter voor antwoorden & correctAntwoord in te voeren.
     */
    private void setAntwoorden(String[] antwoorden, int correctAntwoord)
    {
        if ( antwoorden == null || antwoorden.length < 2 || antwoorden.length > 10 || correctAntwoord < 0 || correctAntwoord >= antwoorden.length )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.antwoorden = antwoorden;
            this.correctAntwoord = correctAntwoord;
        }
    }
    
    /* Methode om score op te vragen */
    public double score(int antwoord, boolean gisCorrectie)
    {
        if ( antwoord == this.correctAntwoord )
        {
            return 1;
        }
        else
        {
            return gisCorrectie ? -0.75 : 0;
        }
    }
    
    /* Verwisselt antwoorden van plaats. Past ook correctAntwoord aan indien nodig */
    private void verwissel(int i, int j)
    {
        /* Antwoorden in de array verwisselen */
        String temp = this.antwoorden[ i ];
        this.antwoorden[i] = this.antwoorden[j];
        this.antwoorden[j] = temp;
        
        /* Veld correctAntwoord aanpassen indien nodig */
        if ( this.correctAntwoord == i )
        {
            correctAntwoord = j;
        }
        else if ( this.correctAntwoord == j )
        {
            correctAntwoord = i;
        }
    }
    
    /* Genereert een random antwoordindex */
    private int randomAntwoordIndex()
    {
        return (int) (Math.random() * antwoorden.length);
    }
    
    /* Verwisselt 2 willekeurige antwoorden van plaats */
    private void verwisselRandomAntwoorden()
    {
        int i = randomAntwoordIndex();
        int j = randomAntwoordIndex();
        
        verwissel(i, j);
    }
    
    /* Schudt de antwoorden doorheen */
    public void haalAntwoordenDoorElkaar()
    {
        for ( int i = 0; i != antwoorden.length; ++i )
        {
            verwisselRandomAntwoorden();
        }
    }
    
    public int stelVraag(int vraagIndex)
    {
        return new GUI().stelVraagEnKrijgAntwoord( vraagIndex, this.vraagstelling, this.antwoorden );
    }
    
    public String getVraagstelling()
    {
        return this.vraagstelling;
    }
}
