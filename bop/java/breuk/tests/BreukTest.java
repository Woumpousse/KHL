import static org.junit.Assert.*;

import org.junit.Test;

public class BreukTest
{
    @Test
    public void ggd()
    {
        assertEquals( 5, Util.ggd( 20, 5 ) );
        assertEquals( 20, Util.ggd( 20, 100 ) );
        assertEquals( 20, Util.ggd( 100, 20 ) );
        assertEquals( 13, Util.ggd( 13 * 7, 13 * 11 ) );
    }

    @Test
    public void testConstructor()
    {
        Breuk a = new Breuk( 1, 2 );

        assertEquals( 1, a.getTeller() );
        assertEquals( 2, a.getNoemer() );
    }
    
    @Test(expected = IllegalArgumentException.class)
    public void constructor_NoemerMagNietNulZijn()
    {
        new Breuk( 1, 0 );
    }

    @Test
    public void constructor_MetVereenvoudigen()
    {
        Breuk a = new Breuk( 2, 4 );

        assertEquals( 1, a.getTeller() );
        assertEquals( 2, a.getNoemer() );
    }
    
    @Test
    public void constructor_MetVereenvoudigen2()
    {
        Breuk a = new Breuk( 2, -5 );

        assertEquals( -2, a.getTeller() );
        assertEquals( 5, a.getNoemer() );
    }
    
    @Test
    public void constructor_TellerNul()
    {
        Breuk a = new Breuk( 0, 1 );

        assertEquals( 0, a.getTeller() );
        assertEquals( 1, a.getNoemer() );
    }
    
    @Test
    public void constructor_TellerNul2()
    {
        Breuk a = new Breuk( 0, 2 );

        assertEquals( 0, a.getTeller() );
        assertEquals( 1, a.getNoemer() );
    }


    @Test
    public void unaireConstructor()
    {
        Breuk b = new Breuk(5);
        
        assertEquals( 5, b.getTeller() );
        assertEquals( 1, b.getNoemer() );
    }
    
    @Test
    public void test_tegengestelde()
    {
        Breuk b = new Breuk(3, 5);
        Breuk r = b.tegengestelde();
        
        assertEquals(-3, r.getTeller());
        assertEquals(5, r.getNoemer());
    }
    
    @Test
    public void vermenigvuldiging1()
    {
        Breuk a = new Breuk( 1, 2 );
        Breuk r = a.vermenigvuldig( a );

        assertEquals( 1, r.getTeller() );
        assertEquals( 4, r.getNoemer() );
    }

    @Test
    public void vermenigvuldiging2()
    {
        Breuk a = new Breuk( 1, 2 );
        Breuk b = new Breuk( 1, 3 );
        Breuk r = a.vermenigvuldig( b );

        assertEquals( 1, r.getTeller() );
        assertEquals( 6, r.getNoemer() );
    }

    @Test
    public void vermenigvuldiging3()
    {
        Breuk a = new Breuk( 1, 2 );
        Breuk b = new Breuk( 2, 3 );
        Breuk r = a.vermenigvuldig( b );

        assertEquals( 1, r.getTeller() );
        assertEquals( 3, r.getNoemer() );
    }

    @Test
    public void optellingMetZelfdeNoemer()
    {
        Breuk a = new Breuk( 1, 2 );
        Breuk b = new Breuk( 1, 2 );
        Breuk r = a.telOp( b );

        assertEquals( 1, r.getTeller() );
        assertEquals( 1, r.getNoemer() );
    }

    @Test
    public void optellingMetVerschillendeNoemer()
    {
        Breuk a = new Breuk( 1, 2 );
        Breuk b = new Breuk( 1, 3 );
        Breuk r = a.telOp( b );

        assertEquals( 5, r.getTeller() );
        assertEquals( 6, r.getNoemer() );
    }

   
    @Test
    public void aftrekkingMetZelfdeNoemer()
    {
        Breuk a = new Breuk(5, 9);
        Breuk b = new Breuk(1, 9);
        Breuk r = a.trekAf( b );
        
        assertEquals( 4, r.getTeller());
        assertEquals( 9, r.getNoemer());
    }
    
    @Test
    public void aftrekkingMetVerschillendeNoemer()
    {
        Breuk a = new Breuk(5, 9);
        Breuk b = new Breuk(1, 10);
        Breuk r = a.trekAf( b );
        
        assertEquals( 41, r.getTeller());
        assertEquals( 90, r.getNoemer());
    }
    
    @Test
    public void aftrekkingMetNegatiefResultaat()
    {
        Breuk a = new Breuk(2, 9);
        Breuk b = new Breuk(9, 7);
        Breuk r = a.trekAf( b );
        
        assertEquals( - 67, r.getTeller());
        assertEquals( 63, r.getNoemer());
    }
    
    @Test
    public void inverteer()
    {
        Breuk a = new Breuk( 1, 3 );
        Breuk b = a.inverteer();

        assertEquals( 3, b.getTeller() );
        assertEquals( 1, b.getNoemer() );
    }

    @Test
    public void deling()
    {
        Breuk a = new Breuk( 1, 3 );
        Breuk b = new Breuk( 3, 5 );
        Breuk r = a.deel( b );

        assertEquals( 5, r.getTeller() );
        assertEquals( 9, r.getNoemer() );
    }

    @Test
    public void delingMetVereenvoudiging()
    {
        Breuk a = new Breuk( 1, 3 );
        Breuk b = new Breuk( 2, 3 );
        Breuk r = a.deel( b );

        assertEquals( 1, r.getTeller() );
        assertEquals( 2, r.getNoemer() );
    }

    @Test
    public void isGelijkAan_ongelijkheid()
    {
        Breuk a = new Breuk( 1, 3 );
        Breuk b = new Breuk( 2, 3 );

        assertFalse( a.isGelijkAan( b ) );
    }

    @Test
    public void isGelijkAan_gelijkheid()
    {
        Breuk a = new Breuk( 2, 3 );
        Breuk b = new Breuk( 2, 3 );

        assertTrue( a.isGelijkAan( b ) );
    }

    @Test
    public void isGelijkAan_gelijkheidNaVereenvoudiging()
    {
        Breuk a = new Breuk( 1, 3 );
        Breuk b = new Breuk( 2, 6 );

        assertTrue( a.isGelijkAan( b ) );
        assertTrue( b.isGelijkAan( a ) );
    }

    @Test
    public void isGelijkAan_gelijkheidNaVereenvoudiging2()
    {
        Breuk a = new Breuk( 1, -3 );
        Breuk b = new Breuk( -2, 6 );

        assertTrue( a.isGelijkAan( b ) );
        assertTrue( b.isGelijkAan( a ) );
    }    
    
    @Test
    public void isNietGelijkAan()
    {
        Breuk a = new Breuk( 1, -3 );
        Breuk b = new Breuk( -2, 6 );

        assertFalse( a.isNietGelijkAan( b ) );
        assertFalse( b.isNietGelijkAan( a ) );
    }
    
    @Test
    public void isKleinerDan()
    {
        assertTrue( new Breuk(1, 10).isKleinerDan( new Breuk(3, 10) ));
        assertTrue( new Breuk(1, 10).isKleinerDan( new Breuk(2, 10) ));
        assertTrue( new Breuk(1, 10).isKleinerDan( new Breuk(1, 5) ));
        assertFalse( new Breuk(5, 10).isKleinerDan( new Breuk(2, 10) ));
        assertFalse( new Breuk(5, 7).isKleinerDan( new Breuk(5, 7) ));
    }
    
    @Test
    public void isGroterDan()
    {
        assertTrue( new Breuk(5, 10).isGroterDan( new Breuk(3, 10) ));
        assertTrue( new Breuk(9, 10).isGroterDan( new Breuk(2, 10) ));
        assertTrue( new Breuk(3, 10).isGroterDan( new Breuk(1, 5) ));
        assertFalse( new Breuk(1, 10).isGroterDan( new Breuk(2, 10) ));
        assertFalse( new Breuk(3, 8).isGroterDan( new Breuk(3, 8) ));
    }
    
    @Test
    public void isKleinerDanOfGelijkAan()
    {
        assertTrue( new Breuk(1, 10).isKleinerDanOfGelijkAan( new Breuk(3, 10) ));
        assertTrue( new Breuk(1, 10).isKleinerDanOfGelijkAan( new Breuk(2, 10) ));
        assertTrue( new Breuk(1, 10).isKleinerDanOfGelijkAan( new Breuk(1, 5) ));
        assertFalse( new Breuk(5, 10).isKleinerDanOfGelijkAan( new Breuk(2, 10) ));
        assertTrue( new Breuk(5, 7).isKleinerDanOfGelijkAan( new Breuk(5, 7) ));
    }

    @Test
    public void isGroterDanOfGelijkAan()
    {
        assertTrue( new Breuk(5, 10).isGroterDanOfGelijkAan( new Breuk(3, 10) ));
        assertTrue( new Breuk(9, 10).isGroterDanOfGelijkAan( new Breuk(2, 10) ));
        assertTrue( new Breuk(3, 10).isGroterDanOfGelijkAan( new Breuk(1, 5) ));
        assertFalse( new Breuk(1, 10).isGroterDanOfGelijkAan( new Breuk(2, 10) ));
        assertTrue( new Breuk(3, 8).isGroterDanOfGelijkAan( new Breuk(3, 8) ));
    }
}
