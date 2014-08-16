public class Game
{
    private Hint hint;
    private int livesLeft;

    public Game(String word)
    {
        if ( word == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            hint = new Hint( word );
            livesLeft = 7;
        }
    }

    public int getLivesLeft()
    {
        return livesLeft;
    }

    public void guess(char c)
    {
        if ( isGameOver() )
        {
            throw new IllegalStateException();
        }
        else
        {
            if ( !hint.guess( c ) )
            {
                livesLeft--;
            }
        }
    }
    
    public boolean isGameOver()
    {
        return isGameWon() || isGameLost();
    }
    
    public boolean isGameWon()
    {
        return hint.isFullyRevealed();
    }
    
    public boolean isGameLost()
    {
        return livesLeft == 0;
    }
    
    public String show()
    {
        return hint.show();
    }
}
