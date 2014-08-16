import static org.junit.Assert.*;

import org.junit.*;


public class StudentTest
{
    private static final String geldigeVoornaam = "Foo";
    private static final String geldigeNaam = "Bar";
    private static final int geldigeCode = 1;
    
    @Test
    public void constructor()
    {
        Student student = new Student(geldigeNaam, geldigeVoornaam, geldigeCode);
        
        assertEquals( geldigeNaam, student.getNaam());
        assertEquals( geldigeVoornaam, student.getVoornaam());
        assertEquals( geldigeCode, student.getCode());
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void constructor_nullNaam()
    {
        new Student(null, geldigeVoornaam, geldigeCode);
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void constructor_nullVoornaam()
    {
        new Student(geldigeNaam, null, geldigeCode);
    }
    
    @Test(expected=IllegalArgumentException.class)
    public void constructor_ongeldigeCode()
    {
        new Student(geldigeNaam, geldigeVoornaam, -1);
    }
}
