import static org.junit.Assert.*;

import org.junit.*;


public class Punt2DTest
{
    @Test
    public void defaultConstructor()
    {
        Punt2D p = new Punt2D();
        
        assertEquals(0, p.getX());
        assertEquals(0, p.getY());
    }

    @Test
    public void binaryConstructor()
    {
        Punt2D p = new Punt2D(3, 5);
        
        assertEquals( 3, p.getX() );
        assertEquals( 5, p.getY() );
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void binaryConstructorWithInvalidArgumentX()
    {
        new Punt2D(-3, 5);
    }

    @Test(expected=IllegalArgumentException.class)
    public void binaryConstructorWithInvalidArgumentY()
    {
        new Punt2D(3, -5);
    }
    
    @Test
    public void setX()
    {
        Punt2D p = new Punt2D(7, 8);
        
        p.setX(3);
        
        assertEquals(3, p.getX());
        assertEquals(8, p.getY());
    }
    
    @Test
    public void setY()
    {
        Punt2D p = new Punt2D(7, 8);
        
        p.setY(3);
        
        assertEquals(7, p.getX());
        assertEquals(3, p.getY());
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void setInvalidX()
    {
        Punt2D p = new Punt2D(7, 8);
        
        p.setX(-3);
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void setInvalidY()
    {
        Punt2D p = new Punt2D(7, 8);
        
        p.setY(-3);
    }
    
    @Test
    public void moveHorizontally()
    {
        Punt2D p = new Punt2D(4, 3);
        
        p.moveHorizontally(1);
        
        assertEquals(5, p.getX());
        assertEquals(3, p.getY());
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void moveHorizontallyIllegally()
    {
        Punt2D p = new Punt2D(1, 3);
        
        p.moveHorizontally(-2);
    }
    
    @Test
    public void moveVertically()
    {
        Punt2D p = new Punt2D(4, 3);
        
        p.moveVertically(2);
        
        assertEquals(4, p.getX());
        assertEquals(5, p.getY());
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void moveVerticallyIllegally()
    {
        Punt2D p = new Punt2D(1, 3);
        
        p.moveVertically(-5);
    }
}
