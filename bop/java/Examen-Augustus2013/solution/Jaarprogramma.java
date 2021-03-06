
public class Jaarprogramma
{
    private Student student;
    
    private Inschrijving[] inschrijvingen;
    
    private int aantalInschrijvingen;
    
    public Jaarprogramma(Student student, int maxAantalInschrijvingen)
    {
        setStudent(student);
        
        inschrijvingen = new Inschrijving[maxAantalInschrijvingen];
        aantalInschrijvingen = 0;
    }
    
    public Jaarprogramma(Student student)
    {
        this(student, 20);
    }
    
    private void setStudent(Student student)
    {
        if ( student == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.student = student;
        }
    }
    
    public void voegInschrijvingToe(Inschrijving inschrijving)
    {
        if ( !kanInschrijvingToevoegen(inschrijving) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            inschrijvingen[aantalInschrijvingen] = inschrijving;
            aantalInschrijvingen++;
        }
    }
    
    public void voegInschrijvingToe(int dag, int maand, int jaar, OPO opo)
    {
        Datum datum = new Datum(dag, maand, jaar);
        Inschrijving inschrijving = new Inschrijving( opo, datum );
        
        voegInschrijvingToe( inschrijving );
    }
    
    private boolean kanInschrijvingToevoegen(Inschrijving inschrijving)
    {
        return inschrijving != null && aantalInschrijvingen() < this.inschrijvingen.length && !bevatInschrijvingVoorOPO(inschrijving.getOpo());
    }
    
    public int aantalInschrijvingen()
    {
        return aantalInschrijvingen;
    }
    
    private boolean bevatInschrijvingVoorOPO(OPO opo)
    {
        for ( int i = 0; i != aantalInschrijvingen(); ++i )
        {
            Inschrijving inschrijving = this.inschrijvingen[i];
            
            if ( inschrijving.getOpo().zelfdeAls( opo ) )
            {
                return true;
            }
        }
        
        return false;
    }
    
    public int geefTotaalAantalStudiePunten()
    {
        int totaal = 0;
        
        for ( int i = 0; i != aantalInschrijvingen(); ++i )
        {
            totaal += this.inschrijvingen[i].getOpo().getStudiePunten();
        }
        
        return totaal;
    }
    
    public double inschrijvingsgeld()
    {
        return 65 + 8.8 * geefTotaalAantalStudiePunten();
    }
    
    public String geefFactuur()
    {
        String result = "";
        
        result += factuurHoofding();
        result += factuurInschrijvingen();
        result += factuurTotaal();
        
        return result;
    }
    
    private String factuurHoofding()
    {
        Student student = getStudent();
        
        return String.format( "Factuur\nStudent: %s %s met code %d\n", student.getVoornaam(), student.getNaam(), student.getCode() );
    }
    
    private String factuurInschrijvingen()
    {
        String result = "";
        
        for ( int i = 0; i != aantalInschrijvingen(); ++i )
        {
            Inschrijving inschrijving = this.inschrijvingen[i];
            
            result += String.format( "%s   %s\n", inschrijving.getDatum(), inschrijving.getOpo().format());
        }
        
        return result;
    }
    
    private String factuurTotaal()
    {
        String lijn1 = String.format( "Totaal aantal studiepunten = %d\n", geefTotaalAantalStudiePunten() );
        String lijn2 = String.format( "Inschrijvingsgeld = %f\n", inschrijvingsgeld() );
        
        return lijn1 + lijn2;
    }

    public Student getStudent()
    {
        return student;
    }
}
