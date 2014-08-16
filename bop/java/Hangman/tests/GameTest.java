import static org.junit.Assert.*;

import org.junit.*;

public class GameTest
{
    @Test
    public void constructor()
    {
        Game hangman = new Game( "zebra" );

        assertFalse( hangman.isGameLost() );
        assertFalse( hangman.isGameWon() );
        assertFalse( hangman.isGameOver() );
        assertEquals( "_ _ _ _ _", hangman.show() );
        assertEquals( 7, hangman.getLivesLeft() );
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructorWithNullWord()
    {
        new Game(null);
    }
    
    @Test
    public void guessRightLetter()
    {
        Game hangman = new Game( "zebra" );

        hangman.guess( 'z' );
        
        assertFalse( hangman.isGameLost() );
        assertFalse( hangman.isGameWon() );
        assertFalse( hangman.isGameOver() );
        assertEquals( "z _ _ _ _", hangman.show() );
        assertEquals( 7, hangman.getLivesLeft() );   
    }
    
    @Test
    public void guessRightLetterTwice()
    {
        Game hangman = new Game( "zebra" );

        hangman.guess( 'z' );
        assertEquals( 7, hangman.getLivesLeft() );   
        hangman.guess( 'z' );
        assertEquals( 6, hangman.getLivesLeft() );
    }

    @Test
    public void guessWrongLetter()
    {
        Game hangman = new Game( "zebra" );

        hangman.guess( 'x' );
        
        assertFalse( hangman.isGameLost() );
        assertFalse( hangman.isGameWon() );
        assertFalse( hangman.isGameOver() );
        assertEquals( "_ _ _ _ _", hangman.show() );
        assertEquals( 6, hangman.getLivesLeft() );   
    }
    
    @Test
    public void winGame()
    {
        Game hangman = new Game( "zebra" );
        
        hangman.guess( 'e' );
        hangman.guess( 'z' );
        hangman.guess( 'b' );
        hangman.guess( 'r' );
        hangman.guess( 'a' );
        
        assertFalse( hangman.isGameLost() );
        assertTrue( hangman.isGameWon() );
        assertTrue( hangman.isGameOver() );
        assertEquals( "z e b r a", hangman.show() );
        assertEquals( 7, hangman.getLivesLeft() );   
    }

    @Test
    public void loseGame()
    {
        Game hangman = new Game( "zebra" );
        
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        
        assertTrue( hangman.isGameLost() );
        assertFalse( hangman.isGameWon() );
        assertTrue( hangman.isGameOver() );
        assertEquals( "_ _ _ _ _", hangman.show() );
        assertEquals( 0, hangman.getLivesLeft() );   
    }
    
    @Test(expected = IllegalStateException.class)
    public void playAfterWinning()
    {
        Game hangman = new Game( "zebra" );
        
        hangman.guess( 'e' );
        hangman.guess( 'z' );
        hangman.guess( 'b' );
        hangman.guess( 'r' );
        hangman.guess( 'a' );        
        
        hangman.guess( 'x' );
    }
    
    @Test(expected = IllegalStateException.class)
    public void playAfterLosing()
    {
        Game hangman = new Game( "zebra" );

        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );
        hangman.guess( 'x' );

        hangman.guess( 'x' );
    }
}
