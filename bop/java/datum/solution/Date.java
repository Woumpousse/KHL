
public class Date
{
    private int day;
    private int month;
    private int year;

    public Date(int day, int month, int year)
    {
        if ( !isValidDate( day, month, year ) )
        {
            throw new IllegalArgumentException();
        }

        this.day = day;
        this.month = month;
        this.year = year;
    }

    public static boolean isLeapYear(int year)
    {
        return year % 4 == 0;
    }

    public static int numberOfDaysInMonth(int month, int year)
    {
        switch ( month )
        {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;

        case 2:
            return isLeapYear( year ) ? 29 : 28;

        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        }

        throw new IllegalArgumentException();
    }

    public static boolean isValidDate(int day, int month, int year)
    {
        return month >= 1 && month <= 12 && day >= 1 && day <= numberOfDaysInMonth( month, year );
    }

    public int getDay()
    {
        return this.day;
    }

    public int getMonth()
    {
        return this.month;
    }

    public int getYear()
    {
        return this.year;
    }

    private void set(int day, int month, int year)
    {
        if ( isValidDate( day, month, year ) )
        {
            this.day = day;
            this.month = month;
            this.year = year;
        }
        else
        {
            throw new IllegalArgumentException();
        }
    }

    public void setYear(int year)
    {
        set( this.day, this.month, year );
    }

    public void setMonth(int month)
    {
        set( this.day, month, this.year );
    }

    public void setDay(int day)
    {
        set( day, this.month, this.year );
    }

    public boolean isBefore(Date other)
    {
        if ( other == null )
        {
            throw new IllegalArgumentException();
        }
        else if ( this.year < other.year )
        {
            return true;
        }
        else if ( this.year == other.year )
        {
            if ( this.month < other.month )
            {
                return true;
            }
            else if ( this.month == other.month )
            {
                return this.day < other.day;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    public boolean isAfter(Date other)
    {
        if ( other == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return other.isBefore( this );
        }
    }

    public void advanceSingleDay()
    {
        if ( this.day == numberOfDaysInMonth( this.month, this.year ) )
        {
            if ( this.month == 12 )
            {
                set( 1, 1, this.year + 1 );
            }
            else
            {
                set( 1, this.month + 1, this.year );
            }
        }
        else
        {
            setDay( this.day + 1 );
        }
    }

    public boolean isSameDate(Date that)
    {
        if ( that == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return this.day == that.day && this.month == that.month && this.year == that.year;
        }
    }

    public void goBackSingleDay()
    {
        if ( this.day == 1 )
        {
            if ( this.month == 1 )
            {
                set( 31, 12, this.year - 1 );
            }
            else
            {
                set( numberOfDaysInMonth( this.month - 1, this.year ), this.month - 1, this.year );
            }
        }
        else
        {
            setDay( this.day - 1 );
        }
    }

    public void advanceDays(int nDays)
    {
        if ( nDays >= 0 )
        {
            for ( int i = 0; i != nDays; ++i )
            {
                advanceSingleDay();
            }
        }
        else
        {
            nDays = -nDays;

            for ( int i = 0; i != nDays; ++i )
            {
                goBackSingleDay();
            }
        }
    }
}
