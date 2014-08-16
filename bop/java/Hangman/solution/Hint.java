
public class Hint
{
    private HintBox[] hintboxes;
    
    public Hint(String word)
    {
        if ( word == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            hintboxes = new HintBox[ word.length() ];
            
            for ( int i = 0; i != hintboxes.length; ++i )
            {
                char letter = word.charAt( i );
                hintboxes[i] = new HintBox( letter );
            }
        }
    }
    
    public boolean isFullyRevealed()
    {
        for ( int i = 0; i != hintboxes.length; ++i )
        {
            if ( !hintboxes[i].isRevealed() )
            {
                return false;
            }
        }
        
        return true;
    }
    
    public boolean guess(char letter)
    {
        boolean result = false;
        
        for ( int i = 0; i != hintboxes.length; ++i )
        {
            result = result || hintboxes[i].guess(letter);
        }
        
        return result;
    }
    
    public String show()
    {
        String result = "";
        boolean first = true;
        
        for ( int i = 0; i !=hintboxes.length; ++i )
        {
            if ( first )
            {
                first = false;
            }
            else
            {
                result += " ";
            }
            
            result += hintboxes[i].show();
        }
        
        return result;
    }
}
