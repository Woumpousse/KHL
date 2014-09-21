import static org.junit.Assert.*;

import org.junit.Test;

public class BreukTests {

    @Test
    public void constructor() {
        Breuk a = new Breuk(1, 2);

        assertEquals(1, a.getTeller());
        assertEquals(2, a.getNoemer());
    }

    @Test
    public void constructor_MoetVereenvoudigen() {
        Breuk a = new Breuk(2, 4);

        assertEquals(1, a.getTeller());
        assertEquals(2, a.getNoemer());
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void constructor_NoemerMagNietNulZijn()
    {
        new Breuk(1, 0);
    }

    @Test
    public void vermenigvuldiging1() {
        Breuk a = new Breuk(1, 2);
        Breuk r = a.vermenigvuldig(a);

        assertEquals(1, r.getTeller());
        assertEquals(4, r.getNoemer());
    }

    @Test
    public void vermenigvuldiging2() {
        Breuk a = new Breuk(1, 2);
        Breuk b = new Breuk(1, 3);
        Breuk r = a.vermenigvuldig(b);

        assertEquals(1, r.getTeller());
        assertEquals(6, r.getNoemer());
    }

    @Test
    public void vermenigvuldiging3() {
        Breuk a = new Breuk(1, 2);
        Breuk b = new Breuk(2, 3);
        Breuk r = a.vermenigvuldig(b);

        assertEquals(1, r.getTeller());
        assertEquals(3, r.getNoemer());
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void vermenigvuldigingMetNull()
    {
        new Breuk(1,2).vermenigvuldig( null );
    }

    @Test
    public void optelling1() {
        Breuk a = new Breuk(1, 2);
        Breuk b = new Breuk(1, 2);
        Breuk r = a.telOp(b);

        assertEquals(1, r.getTeller());
        assertEquals(1, r.getNoemer());
    }

    @Test
    public void optelling2() {
        Breuk a = new Breuk(1, 2);
        Breuk b = new Breuk(1, 3);
        Breuk r = a.telOp(b);

        assertEquals(5, r.getTeller());
        assertEquals(6, r.getNoemer());
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void optellingMetNull()
    {
        new Breuk(1,2).telOp( null );
    }
    
    @Test
    public void inverteer()
    {
        Breuk a = new Breuk(1, 3);
        Breuk b = a.inverteer();
        
        assertEquals(3, b.getTeller());
        assertEquals(1, b.getNoemer());
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void inverteerNul()
    {
        Breuk a = new Breuk(0, 1);
        a.inverteer();
    }
    
    @Test
    public void deling()
    {
        Breuk a = new Breuk(1, 3);
        Breuk b = new Breuk(3, 5);
        Breuk r = a.deel( b );
        
        assertEquals(5, r.getTeller());
        assertEquals(9, r.getNoemer());
    }
    
    @Test
    public void delingMetVereenvoudiging()
    {
        Breuk a = new Breuk(1, 3);
        Breuk b = new Breuk(2, 3);
        Breuk r = a.deel( b );
        
        assertEquals(1, r.getTeller());
        assertEquals(2, r.getNoemer());
    }
    
    @Test(expected=IllegalArgumentException.class) public void delingDoorNull()
    {
        new Breuk(1, 3).deel( null );
    }
    
    @Test public void isGelijkAan_ongelijkheid()
    {
        Breuk a = new Breuk(1, 3);
        Breuk b = new Breuk(2, 3);
        
        assertFalse(a.isGelijkAan( b ));
    }
    
    @Test public void isGelijkAan_gelijkheid()
    {
        Breuk a = new Breuk(2, 3);
        Breuk b = new Breuk(2, 3);
        
        assertTrue(a.isGelijkAan( b ));
    }
    
    @Test(expected=IllegalArgumentException.class) public void isGelijkAan_null()
    {
        new Breuk(1, 3).isGelijkAan( null );
    }
}
