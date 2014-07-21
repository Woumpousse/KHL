public class Klas
{
    private Student[] studenten;

    public Klas(int capaciteit)
    {
        if ( capaciteit <= 0 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.studenten = new Student[capaciteit];
        }
    }

    public Klas()
    {
        this( 30 );
    }

    public int capaciteit()
    {
        return this.studenten.length;
    }

    public int aantalStudenten()
    {
        return telAantalStudenten();
    }

    public int aantalVrijePlaatsen()
    {
        return capaciteit() - aantalStudenten();
    }

    private int vindVrijelaats()
    {
        for ( int i = 0; i != this.studenten.length; ++i )
        {
            if ( this.studenten[i] == null )
                return i;
        }

        return -1;
    }

    public void voegStudentToe(Student student)
    {
        if ( bevatStudentMetNaam( student.getNaam() ) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            int idx = vindVrijelaats();

            if ( idx == -1 )
            {
                throw new IllegalArgumentException();
            }
            else
            {
                this.studenten[idx] = student;
            }
        }
    }

    public Student vindStudentMetNaam(String naam)
    {
        for ( int i = 0; i != this.studenten.length; ++i )
        {
            if ( this.studenten[i] != null )
            {
                if ( this.studenten[i].getNaam().equals( naam ) )
                {
                    return this.studenten[i];
                }
            }
        }

        return null;
    }

    private boolean bevatStudentMetNaam(String naam)
    {
        return vindStudentMetNaam( naam ) != null;
    }

    private int telAantalStudenten()
    {
        int aantal = 0;

        for ( int i = 0; i != this.studenten.length; ++i )
        {
            if ( this.studenten[i] != null )
            {
                ++aantal;
            }
        }

        return aantal;
    }

    public String[] studentenLijst()
    {
        String[] namen = new String[telAantalStudenten()];
        int naamIndex = 0;

        for ( int i = 0; i != this.studenten.length; ++i )
        {
            if ( this.studenten[i] != null )
            {
                namen[naamIndex] = this.studenten[i].getNaam();
                naamIndex++;
            }
        }

        return namen;
    }

    public double gemiddelde(String vakNaam)
    {
        double totaal = 0;
        int aantalStudenten = 0;

        for ( int i = 0; i != this.studenten.length; ++i )
        {
            Student huidigeStudent = this.studenten[i];
            
            if ( huidigeStudent != null && huidigeStudent.volgtVak(vakNaam) )
            {
                Vak vak = huidigeStudent.vindVak( vakNaam );

                if ( vak != null )
                {
                    totaal += vak.getPunten();
                    ++aantalStudenten;
                }
            }
        }

        return totaal / aantalStudenten;
    }
}
