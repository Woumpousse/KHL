
public class HintBox
{
    private char letter;
    private boolean revealed;
    
    public HintBox(char letter)
    {
        this.letter = Character.toLowerCase(  letter );
        this.revealed = false;
    }
    
    public boolean isRevealed()
    {
        return revealed;
    }
    
    public boolean guess(char letter)
    {
        letter = Character.toLowerCase( letter );
        
        if ( !revealed && this.letter == letter )
        {
            revealed = true;
            
            return true;
        }
        else
        {
            return false;
        }
    }
    
    public char show()
    {
        if ( isRevealed() )
        {
            return letter;
        }
        else
        {
            return '_';
        }
    }
}
