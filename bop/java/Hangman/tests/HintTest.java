import static org.junit.Assert.*;

import org.junit.*;

public class HintTest
{
    @Test
    public void constructor()
    {
        Hint hint = new Hint( "xyz" );

        assertFalse( hint.isFullyRevealed() );
        assertEquals( "_ _ _", hint.show() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructorWithNullWord()
    {
        new Hint( null );
    }

    @Test
    public void guessRightLetter()
    {
        Hint hint = new Hint( "abc" );

        assertTrue( hint.guess( 'a' ) );
        assertFalse( hint.isFullyRevealed() );
        assertEquals( "a _ _", hint.show() );

        assertTrue( hint.guess( 'c' ) );
        assertFalse( hint.isFullyRevealed() );
        assertEquals( "a _ c", hint.show() );

        assertTrue( hint.guess( 'b' ) );
        assertTrue( hint.isFullyRevealed() );
        assertEquals( "a b c", hint.show() );
    }

    @Test
    public void guessRightLetterInUppercase()
    {
        Hint hint = new Hint( "abc" );

        assertTrue( hint.guess( 'A' ) );
        assertFalse( hint.isFullyRevealed() );
        assertEquals( "a _ _", hint.show() );

        assertTrue( hint.guess( 'C' ) );
        assertFalse( hint.isFullyRevealed() );
        assertEquals( "a _ c", hint.show() );

        assertTrue( hint.guess( 'B' ) );
        assertTrue( hint.isFullyRevealed() );
        assertEquals( "a b c", hint.show() );
    }

    @Test
    public void guessWrongLetter()
    {
        Hint hint = new Hint( "abc" );

        assertFalse( hint.guess( 'x' ) );
        assertFalse( hint.isFullyRevealed() );
        assertEquals( "_ _ _", hint.show() );
    }

    @Test
    public void guessRightLetterTwice()
    {
        Hint hint = new Hint( "abc" );

        assertTrue( hint.guess( 'b' ) );
        assertFalse( hint.guess( 'b' ) );
    }
}
