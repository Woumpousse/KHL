import static org.junit.Assert.*;

import org.junit.*;


public class OPOTest
{
    private static final int geldigeCode = 1;
    private static final String geldigeNaam = "x";
    private static final int geldigeStudiePunten = 1;
    
    @Test
    public void constructor()
    {
        OPO opo = new OPO(geldigeCode, geldigeNaam, geldigeStudiePunten, true);
        
        assertEquals( geldigeCode, opo.getCode() );
        assertEquals( geldigeNaam, opo.getNaam() );
        assertEquals( geldigeStudiePunten, opo.getStudiePunten() );
        assertTrue( opo.isEngels() );
    }
    
    @Test
    public void constructor2()
    {
        OPO opo = new OPO(geldigeCode, geldigeNaam, geldigeStudiePunten);
        
        assertEquals( geldigeCode, opo.getCode() );
        assertEquals( geldigeNaam, opo.getNaam() );
        assertEquals( geldigeStudiePunten, opo.getStudiePunten() );
        assertFalse( opo.isEngels() );
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void constructor_nullNaam()
    {
        new OPO(0, null, geldigeStudiePunten);
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void constructor_negatieveStudiePunten()
    {
        new OPO(0, geldigeNaam, -1);
    }
    
    @Test
    public void zelfdeAls()
    {
        OPO opo1 = new OPO( 1, "x", 1);
        OPO opo2 = new OPO( 2, "y", 1);
        OPO opo3 = new OPO( 1, "y", 1);
        
        assertTrue(opo1.zelfdeAls( opo1 ));
        assertTrue(opo2.zelfdeAls( opo2 ));
        assertTrue(opo3.zelfdeAls( opo3 ));
        assertFalse(opo1.zelfdeAls( opo2 ));
        assertFalse(opo2.zelfdeAls( opo1 ));
        assertTrue(opo1.zelfdeAls( opo3 ));
        assertTrue(opo3.zelfdeAls( opo1 ));
    }
}
