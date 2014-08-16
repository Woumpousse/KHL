public class App
{
    public static void main(String[] args)
    {
        UserInterface ui = new UserInterface();
        Game game = new Game( "zebra" );

        while ( !game.isGameOver() )
        {
            char letter = ui.askChar( String.format( "Hint: %s\nAantal levens: %d\nGok een letter", game.show(), game.getLivesLeft() ) );
            game.guess( letter );
        }

        if ( game.isGameWon() )
        {
            ui.showMessage( "Gewonnen!" );
        }
        else
        {
            ui.showMessage( "Verloren!" );
        }
    }
}
