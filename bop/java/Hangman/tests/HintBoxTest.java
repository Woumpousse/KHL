import static org.junit.Assert.*;

import org.junit.*;

public class HintBoxTest
{
    @Test
    public void constructor()
    {
        HintBox box = new HintBox( 'a' );

        assertFalse( box.isRevealed() );
        assertEquals( '_', box.show() );
    }

    @Test
    public void guessRightLetter()
    {
        HintBox box = new HintBox( 'x' );

        assertTrue( box.guess( 'x' ) );
        assertTrue( box.isRevealed() );
        assertEquals( 'x', box.show() );
    }

    @Test
    public void guessRightLetterInUpperCase()
    {
        HintBox box = new HintBox( 'x' );

        assertTrue( box.guess( 'X' ) );
        assertTrue( box.isRevealed() );
        assertEquals( 'x', box.show() );
    }

    @Test
    public void guessRightLetterInitializedInUpperCase()
    {
        HintBox box = new HintBox( 'X' );

        assertTrue( box.guess( 'x' ) );
        assertTrue( box.isRevealed() );
        assertEquals( 'x', box.show() );
    }

    @Test
    public void guessWrongLetter()
    {
        HintBox box = new HintBox( 'x' );

        assertFalse( box.guess( 'y' ) );
        assertFalse( box.isRevealed() );
        assertEquals( '_', box.show() );
    }
    
    @Test
    public void guessRightLetterTwice()
    {
        HintBox box = new HintBox( 'f');
        
        assertTrue( box.guess( 'f' ) );
        assertFalse( box.guess( 'f' ) );
    }
}
