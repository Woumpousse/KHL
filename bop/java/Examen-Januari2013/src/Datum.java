import java.util.Calendar;

public class Datum implements Comparable<Datum>
{
    private final int dag;
    private final int maand;
    private final int jaar;

    public static final int JANUARI = 1;
    public static final int FEBRUARI = 2;
    public static final int MAART = 3;
    public static final int APRIL = 4;
    public static final int MEI = 5;
    public static final int JUNI = 6;
    public static final int JULI = 7;
    public static final int AUGUSTUS = 8;
    public static final int SEPTEMBER = 9;
    public static final int OKTOBER = 10;
    public static final int NOVEMBER = 11;
    public static final int DECEMBER = 12;

    public static final int MILLISECONDEN_PER_SECONDE = 1000;
    public static final int SECONDE_PER_MINUUT = 60;
    public static final int MINUUT_PER_UUR = 60;
    public static final int UUR_PER_DAG = 24;

    public static final int MAANDAG = Calendar.MONDAY;
    public static final int DINSDAG = Calendar.TUESDAY;
    public static final int WOENSDAG = Calendar.WEDNESDAY;
    public static final int DONDERDAG = Calendar.THURSDAY;
    public static final int VRIJDAG = Calendar.FRIDAY;
    public static final int ZATERDAG = Calendar.SATURDAY;
    public static final int ZONDAG = Calendar.SUNDAY;

    public static Datum vandaag()
    {
        Calendar nu = Calendar.getInstance();

        int dag = nu.get( Calendar.DAY_OF_MONTH );
        int maand = nu.get( Calendar.MONTH ) + 1;
        int jaar = nu.get( Calendar.YEAR );

        return new Datum( dag, maand, jaar );
    }

    public Datum(int dag, int maand, int jaar)
    {
        if ( !isGeldigeDatum( dag, maand, jaar ) )
        {
            throw new IllegalArgumentException( "Ongeldige datum" );
        }
        else
        {
            this.dag = dag;
            this.maand = maand;
            this.jaar = jaar;
        }
    }

    private static boolean isGeldigeDatum(int dag, int maand, int jaar)
    {
        return isGeldigeMaand( maand ) && isGeldigeDag( dag, maand, jaar );
    }

    private static boolean isGeldigeMaand(int maand)
    {
        return JANUARI <= maand && maand <= DECEMBER;
    }

    private static boolean isGeldigeDag(int dag, int maand, int jaar)
    {
        return 1 <= dag && dag <= aantalDagenInMaand( maand, jaar );
    }

    private static int aantalDagenInMaand(int maand, int jaar)
    {
        final int result;

        switch ( maand )
        {
        case JANUARI:
        case MAART:
        case MEI:
        case JULI:
        case AUGUSTUS:
        case OKTOBER:
        case DECEMBER:
            result = 31;
            break;

        case FEBRUARI:
            result = isSchrikkeljaar( jaar ) ? 29 : 28;
            break;

        case APRIL:
        case JUNI:
        case SEPTEMBER:
        case NOVEMBER:
            result = 30;
            break;

        default:
            throw new IllegalArgumentException( "Ongeldige maand" );
        }

        return result;
    }

    private static boolean isSchrikkeljaar(int jaar)
    {
        final boolean result;

        if ( jaar % 400 == 0 )
        {
            result = true;
        }
        else if ( jaar % 100 == 0 )
        {
            result = false;
        }
        else if ( jaar % 4 == 0 )
        {
            result = true;
        }
        else
        {
            result = false;
        }

        return result;
    }

    public int getDag()
    {
        return this.dag;
    }

    public int getMaand()
    {
        return this.maand;
    }

    public int getJaar()
    {
        return this.jaar;
    }

    @Override
    public boolean equals(Object object)
    {
        final boolean result;

        if ( object instanceof Datum )
        {
            Datum that = (Datum) object;

            result = this.getDag() == that.getDag() && this.getMaand() == that.getMaand() && this.getJaar() == that.getJaar();
        }
        else
        {
            result = false;
        }

        return result;
    }

    @Override
    public int hashCode()
    {
        return getDag() + getMaand() * 31 + this.getJaar() * 366;
    }

    @Override
    public int compareTo(Datum that)
    {
        if ( that == null )
        {
            throw new IllegalArgumentException( "Ongeldige datum" );
        }
        else
        {
            final int result;

            if ( this.getJaar() < that.getJaar() )
            {
                result = -1;
            }
            else if ( this.getJaar() > that.getJaar() )
            {
                result = +1;
            }
            else if ( this.getMaand() < that.getMaand() )
            {
                result = -1;
            }
            else if ( this.getMaand() > that.getMaand() )
            {
                result = +1;
            }
            else
            {
                result = this.getDag() - that.getDag();
            }

            return result;
        }
    }

    @Override
    public String toString()
    {
        return format();
    }

    public String format()
    {
        return String.format( "%02d/%02d/%04d", this.getDag(), this.getMaand(), this.getJaar() );
    }

    public boolean valtTussen(Datum min, Datum max)
    {
        if ( min == null )
        {
            throw new IllegalArgumentException( "Ongeldige min" );
        }
        else if ( max == null )
        {
            throw new IllegalArgumentException( "Ongeldige max" );
        }
        else
        {
            return min.compareTo( this ) <= 0 && this.compareTo( max ) <= 0;
        }
    }

    private Calendar asCalendar()
    {
        Calendar calendar = Calendar.getInstance();
        calendar.set( this.jaar, this.maand - 1, this.dag );

        return calendar;
    }

    public int leeftijd(Datum geboorteDatum)
    {
        int resultaat = this.getJaar() - geboorteDatum.getJaar();

        if ( this.getMaand() < geboorteDatum.getMaand() || (this.getMaand() == geboorteDatum.getMaand() && this.getDag() < geboorteDatum.getDag()) )
        {
            --resultaat;
        }

        return resultaat;
    }

    public boolean komtVoor(Datum datum)
    {
        return this.compareTo( datum ) < 0;
    }

    public boolean komtNa(Datum datum)
    {
        return this.compareTo( datum ) > 0;
    }

    public boolean isGelijkAan(Datum datum)
    {
        return this.equals( datum );
    }

    public int dagVanDeWeek()
    {
        return asCalendar().get( Calendar.DAY_OF_WEEK );
    }
}
