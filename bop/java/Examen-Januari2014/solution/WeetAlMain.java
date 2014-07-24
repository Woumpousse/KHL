public class WeetAlMain
{
    public static void main(String[] args)
    {
        GUI gui = new GUI();

        // Definieer een examen met 5 mogelijke vragen
        Examen examen = new Examen( 5 );

        // Voeg de eerste vraag toe aan het examen
        MeerkeuzeVraag vraag1 = new MeerkeuzeVraag( "Wat is geen Java keyword?", new String[] { "for", "int", "public", "round" }, 3 );
        examen.voegVraagToe( vraag1 );

        // Voeg de tweede vraag toe aan het examen
        MeerkeuzeVraag vraag2 = new MeerkeuzeVraag( "Bla bla bla?", new String[] { "a", "b", "c" }, 0 );
        examen.voegVraagToe( vraag2 );

        // Wijzig de vraagvolgorde en bij elke vraag de antwoordvolgorde
        // willekeurig
        examen.haalVragenEnAntwoordenDoorElkaar();

        // Zeg tegen de gebruiker dat het examen start
        gui.geefInfo( "Examen", "Examen begint nu" );

        // Neem het examen af en verzamel de antwoorden
        int[] antwoorden = examen.legAf();
        
        // Bereken de score met en zonder giscorrectie
        int scoreMetGisCorrectie = examen.score( antwoorden, true );
        int scoreZonderGisCorrectie = examen.score( antwoorden, false );

        // Geef de student zijn score
        gui.geefInfo( "Score", "Je haalde (met giscorrectie)" + scoreMetGisCorrectie + " of (zonder giscorrectie)" + scoreZonderGisCorrectie );
    }
}
