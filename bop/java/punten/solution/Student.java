
public class Student
{
    private final String naam;

    private Vak[] vakken;

    public Student( String naam )
    {
        this.naam = naam;
        this.vakken = new Vak[0];
    }

    public String getNaam()
    {
        return this.naam;
    }

    public int aantalVakken()
    {
        return this.vakken.length;
    }

    private int vindIndexVanVak( String vakNaam )
    {
        for ( int i = 0; i != this.vakken.length; ++i )
        {
            if ( this.vakken[i].getNaam().equals( vakNaam ) )
            {
                return i;
            }
        }

        return -1;
    }

    public Vak vindVak( int index )
    {
        if ( 0 <= index && index < aantalVakken() )
        {
            return this.vakken[index];
        }
        else
        {
            throw new IllegalArgumentException();
        }
    }

    public boolean volgtVak(String vakNaam)
    {
        return vindIndexVanVak( vakNaam ) != -1;
    }
    
    public Vak vindVak( String vakNaam )
    {
        int index = vindIndexVanVak( vakNaam );

        if ( index == -1 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return this.vakken[index];
        }
    }

    private boolean heeftVakMetNaam( String vakNaam )
    {
        return vindIndexVanVak( vakNaam ) != -1;
    }

    public void voegPuntenToe( Vak vak )
    {
        if ( heeftVakMetNaam( vak.getNaam() ) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            Vak[] arr = new Vak[this.vakken.length + 1];
            for ( int i = 0; i != this.vakken.length; ++i )
            {
                arr[i] = this.vakken[i];
            }
            arr[this.vakken.length] = vak;

            this.vakken = arr;
        }
    }

    public double totaal()
    {
        int totaal = 0;

        for ( int i = 0; i != this.vakken.length; ++i )
        {
            totaal += this.vakken[i].getPunten();
        }

        return totaal * 5.0 / this.vakken.length;
    }
}
