public class Kind
{
    private String voornaam;
    private String familieNaam;
    private Datum geboorteDatum;

    public Kind(String voornaam, String familieNaam, Datum geboorteDatum)
    {
        setVoornaam( voornaam );
        setFamilieNaam( familieNaam );
        setGeboorteDatum( geboorteDatum );
    }

    private void setFamilieNaam(String familieNaam)
    {
        if ( familieNaam == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.familieNaam = familieNaam;
        }
    }

    private void setVoornaam(String voornaam)
    {
        if ( voornaam == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.voornaam = voornaam;
        }
    }

    private void setGeboorteDatum(Datum geboorteDatum)
    {
        if ( geboorteDatum == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.geboorteDatum = geboorteDatum;
        }
    }

    public String getVoornaam()
    {
        return voornaam;
    }

    public String getFamilieNaam()
    {
        return familieNaam;
    }

    public Datum getGeboorteDatum()
    {
        return geboorteDatum;
    }
    
    public int getLeeftijd(Datum datum)
    {
        if ( datum == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return datum.leeftijd( this.geboorteDatum );
        }
    }
}
