
public class OPO
{
    private int code;
    
    private String naam;
    
    private int studiePunten;
    
    private boolean engels;
    
    public OPO(int code, String naam, int studiePunten, boolean engels)
    {
        setCode(code);
        setNaam( naam );
        setStudiePunten( studiePunten );
        setEngels( engels );
    }
    
    public OPO(int code, String naam, int studiePunten )
    {
        this(code, naam, studiePunten, false);
    }
    
    private void setCode(int code)
    {
        this.code = code;
    }
    
    private void setNaam(String naam)
    {
        if ( !isNonEmptyString(naam) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.naam = naam;
        }
    }
    
    private boolean isNonEmptyString(String string)
    {
        return string != null && string.trim().length() > 0;
    }
    
    private void setStudiePunten(int studiePunten)
    {
        if ( !isValidStudiePunten(studiePunten) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.studiePunten = studiePunten;
        }
    }
    
    private boolean isValidStudiePunten(int studiePunten)
    {
        return studiePunten > 0;
    }
    
    private void setEngels(boolean engels)
    {
        this.engels = engels;
    }

    public int getCode()
    {
        return code;
    }

    public String getNaam()
    {
        return naam;
    }

    public int getStudiePunten()
    {
        return studiePunten;
    }

    public boolean isEngels()
    {
        return engels;
    }
    
    public boolean zelfdeAls(OPO opo)
    {
        return this.getCode() == opo.getCode();
    }
    
    public String format()
    {
        return String.format( "%s, code = %d, %sgegeven in het Engels, %dstp", getNaam(), getCode(), isEngels() ? "" : "niet ", getStudiePunten() );
    }
}
