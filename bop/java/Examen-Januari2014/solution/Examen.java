

public class Examen
{
    /* Velden */
    private MeerkeuzeVraag[] vragen;
    private int aantalVragen;
        
    /* Constructor */
    public Examen(int aantalVragen)
    {
        vragen = new MeerkeuzeVraag[aantalVragen];
        aantalVragen = 0;
    }
    
    private boolean bevatVraagMetVraagstelling(String vraagstelling)
    {
        for ( int i = 0; i != aantalVragen; ++i )
        {
            if ( vragen[i].getVraagstelling().equals(vraagstelling))
            {
                return true;
            }
        }
        
        return false;
    }
    
    public void voegVraagToe(MeerkeuzeVraag vraag)
    {
        if ( vraag == null || aantalVragen == vragen.length || bevatVraagMetVraagstelling( vraag.getVraagstelling() ))
        {
            throw new IllegalArgumentException();
        }
        else
        {
            vragen[aantalVragen] = vraag;
            aantalVragen++;
        }
    }
    
    private void verwisselVragen(int i, int j)
    {
        MeerkeuzeVraag temp = vragen[i];
        vragen[i] = vragen[j];
        vragen[j] = temp;
    }    
    
    private int randomVraagIndex()
    {
        return (int) (Math.random() * aantalVragen);
    }
    
    private void verwisselRandomVragen()
    {
        int i = randomVraagIndex();
        int j = randomVraagIndex();
        
        verwisselVragen( i, j );
    }
    
    private void haalVragenDoorElkaar()
    {
        for ( int i = 0; i != aantalVragen; ++i )
        {
            verwisselRandomVragen();
        }
    }
    
    private void haalAntwoordenVanElkeVraagDoorElkaar()
    {
        for ( int i = 0; i != aantalVragen; ++i )
        {
            this.vragen[i].haalAntwoordenDoorElkaar();
        }
    }
    
    public void haalVragenEnAntwoordenDoorElkaar()
    {
        haalVragenDoorElkaar();
        haalAntwoordenVanElkeVraagDoorElkaar();
    }
    
    public int[] legAf()
    {
        int[] antwoorden = new int[aantalVragen];
        
        for ( int i = 0; i != aantalVragen; ++i )
        {
            antwoorden[i] = this.vragen[i].stelVraag( i );
        }
        
        return antwoorden;
    }
    
    public int score(int[] antwoorden, boolean gisCorrectie)
    {
        if ( antwoorden == null ) {
            throw new IllegalArgumentException();
        }
        else
        {
            int totaal = 0;
            
            for ( int i = 0; i != aantalVragen; ++i )
            {
                totaal += this.vragen[i].score( antwoorden[i], gisCorrectie );
            }
            
            return totaal;
        }
    }
}
