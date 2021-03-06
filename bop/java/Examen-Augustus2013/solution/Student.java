public class Student
{
    private String naam;

    private String voornaam;

    private int code;

    public Student(String naam, String voornaam, int code)
    {
        setNaam(naam);
        setVoornaam( voornaam );
        setCode( code );
    }

    private void setNaam(String naam)
    {
        if ( !isNonEmptyString( naam ) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.naam = naam;
        }
    }

    private void setVoornaam(String voornaam)
    {
        if ( !isNonEmptyString( voornaam ) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.voornaam = voornaam;
        }
    }
    
    private void setCode(int code)
    {
        if ( !isValidCode( code ) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.code = code;
        }
    }

    private boolean isNonEmptyString(String string)
    {
        return string != null && string.trim().length() > 0;
    }
    
    private boolean isValidCode(int code)
    {
        return code >= 100000 && code <= 999999;
    }

    public String getNaam()
    {
        return naam;
    }

    public String getVoornaam()
    {
        return voornaam;
    }

    public int getCode()
    {
        return code;
    }
}
