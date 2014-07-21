

import static org.junit.Assert.*;

import org.junit.Test;

public class DateTest
{
    @Test public void leapYearsTests()
    {
        // isLeapYear is statisch!!!
        // Implementeer dit als
        // public static boolean isLeapYear(int year) { ... }
        assertTrue( Date.isLeapYear( 1980 ) );
        assertTrue( Date.isLeapYear( 1984 ) );
        assertTrue( Date.isLeapYear( 1988 ) );
        assertTrue( Date.isLeapYear( 1992 ) );
        assertTrue( Date.isLeapYear( 1996 ) );
        assertTrue( Date.isLeapYear( 2000 ) );
        assertTrue( Date.isLeapYear( 2004 ) );
        assertTrue( Date.isLeapYear( 2008 ) );
    }

    @Test public void nonLeapYearsests()
    {
        assertFalse( Date.isLeapYear( 1981 ) );
        assertFalse( Date.isLeapYear( 1991 ) );
        assertFalse( Date.isLeapYear( 1993 ) );
        assertFalse( Date.isLeapYear( 1995 ) );
        assertFalse( Date.isLeapYear( 2001 ) );
        assertFalse( Date.isLeapYear( 2002 ) );
        assertFalse( Date.isLeapYear( 2003 ) );
        assertFalse( Date.isLeapYear( 2009 ) );
        assertFalse( Date.isLeapYear( 2011 ) );
        assertFalse( Date.isLeapYear( 2013 ) );
    }

    @Test public void numberOfDaysInMonthTests()
    {
        // Statische methode!!!
        assertEquals( 31, Date.numberOfDaysInMonth( 1, 2001 ) ); // January
        assertEquals( 28, Date.numberOfDaysInMonth( 2, 2001 ) ); // February
        assertEquals( 28, Date.numberOfDaysInMonth( 2, 2003 ) );
        assertEquals( 29, Date.numberOfDaysInMonth( 2, 2004 ) );
        assertEquals( 28, Date.numberOfDaysInMonth( 2, 2005 ) );
        assertEquals( 29, Date.numberOfDaysInMonth( 2, 2008 ) );
        assertEquals( 31, Date.numberOfDaysInMonth( 3, 2008 ) ); // March
        assertEquals( 30, Date.numberOfDaysInMonth( 4, 2008 ) ); // April
        assertEquals( 31, Date.numberOfDaysInMonth( 5, 2008 ) ); // May
        assertEquals( 30, Date.numberOfDaysInMonth( 6, 2008 ) ); // June
        assertEquals( 31, Date.numberOfDaysInMonth( 7, 2008 ) ); // July
        assertEquals( 31, Date.numberOfDaysInMonth( 8, 2008 ) ); // August
        assertEquals( 30, Date.numberOfDaysInMonth( 9, 2008 ) ); // September
        assertEquals( 31, Date.numberOfDaysInMonth( 10, 2008 ) ); // October
        assertEquals( 30, Date.numberOfDaysInMonth( 11, 2008 ) ); // November
        assertEquals( 31, Date.numberOfDaysInMonth( 12, 2008 ) ); // December
    }

    @Test(expected = IllegalArgumentException.class) public void numberOfDaysInMonthInvalidMonthTests()
    {
        Date.numberOfDaysInMonth( 13, 2000 );
    }

    @Test public void isValidDateTests()
    {
        // Statische methode!!!
        assertTrue( Date.isValidDate( 1, 1, 2000 ) );
        assertTrue( Date.isValidDate( 29, 2, 2000 ) );
        assertTrue( Date.isValidDate( 31, 1, 2000 ) );
        assertTrue( Date.isValidDate( 31, 3, 2000 ) );
        assertTrue( Date.isValidDate( 31, 12, 2000 ) );

        assertFalse( Date.isValidDate( 0, 1, 2001 ) ); // Wrong day
        assertFalse( Date.isValidDate( 32, 1, 2001 ) ); // Wrong day
        assertFalse( Date.isValidDate( 1, 0, 2001 ) ); // Wrong month
        assertFalse( Date.isValidDate( 1, 13, 2001 ) ); // Wrong month
        assertFalse( Date.isValidDate( 29, 2, 2001 ) ); // Not a leap year
    }

    @Test public void constructorTests1()
    {
        Date date = new Date( 1, 1, 2000 );

        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void constructorTests2()
    {
        Date date = new Date( 29, 2, 2000 );

        assertEquals( 29, date.getDay() );
        assertEquals( 2, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test(expected = IllegalArgumentException.class) public void constructorWithInvalidMonthTests()
    {
        // Moet falen wegens ongeldige maand
        new Date( 1, 13, 2001 );
    }

    @Test(expected = IllegalArgumentException.class) public void constructorWithInvalidDayTests1()
    {
        // Moet falen wegens ongeldige dag
        new Date( 32, 12, 2001 );
    }

    @Test(expected = IllegalArgumentException.class) public void constructorWithInvalidDayTests2()
    {
        // Moet falen wegens ongeldige dag
        new Date( 29, 2, 2001 );
    }

    @Test public void setDayTests()
    {
        Date date = new Date( 1, 1, 2000 );
        date.setDay( 2 );

        assertEquals( 2, date.getDay() );
    }

    @Test(expected = IllegalArgumentException.class) public void setDayTestsInvalid1()
    {
        Date date = new Date( 1, 1, 2000 );
        date.setDay( 0 );
    }

    @Test(expected = IllegalArgumentException.class) public void setDayTestsInvalid2()
    {
        Date date = new Date( 1, 2, 2001 );
        date.setDay( 29 );
    }

    @Test public void setMonthTests()
    {
        Date date = new Date( 1, 1, 2000 );
        date.setMonth( 2 );

        assertEquals( 2, date.getMonth() );
    }

    @Test(expected = IllegalArgumentException.class) public void setMonthsInvalidTests1()
    {
        Date date = new Date( 1, 1, 2000 );
        date.setMonth( 13 );
    }

    @Test(expected = IllegalArgumentException.class) public void setMonthsInvalidTests2()
    {
        Date date = new Date( 31, 12, 2000 );
        date.setMonth( 2 );
    }

    @Test public void setYearTests()
    {
        Date date = new Date( 1, 1, 2000 );
        date.setYear( 2001 );

        assertEquals( 2001, date.getYear() );
    }

    @Test(expected = IllegalArgumentException.class) public void setYearInvalidTests1()
    {
        Date date = new Date( 29, 2, 2000 );
        date.setYear( 2003 );
    }

    @Test public void isBeforeTests()
    {
        assertTrue( new Date( 1, 1, 2000 ).isBefore( new Date( 1, 1, 2001 ) ) );
        assertTrue( new Date( 1, 1, 2000 ).isBefore( new Date( 1, 2, 2000 ) ) );
        assertTrue( new Date( 1, 1, 2000 ).isBefore( new Date( 2, 1, 2000 ) ) );
        assertTrue( new Date( 31, 1, 2000 ).isBefore( new Date( 1, 2, 2000 ) ) );
        assertTrue( new Date( 31, 12, 2000 ).isBefore( new Date( 1, 1, 2001 ) ) );
        assertTrue( new Date( 15, 1, 2000 ).isBefore( new Date( 16, 1, 2000 ) ) );
        assertTrue( new Date( 15, 1, 2000 ).isBefore( new Date( 15, 3, 2000 ) ) );
        assertTrue( new Date( 15, 1, 2000 ).isBefore( new Date( 15, 1, 2001 ) ) );

        assertFalse( new Date( 1, 1, 2000 ).isBefore( new Date( 1, 1, 2000 ) ) );
        assertFalse( new Date( 1, 1, 2001 ).isBefore( new Date( 1, 1, 2000 ) ) );
        assertFalse( new Date( 3, 1, 2000 ).isBefore( new Date( 2, 1, 2000 ) ) );
        assertFalse( new Date( 1, 2, 2000 ).isBefore( new Date( 1, 1, 2000 ) ) );
        assertFalse( new Date( 9, 10, 2001 ).isBefore( new Date( 9, 10, 2000 ) ) );
        assertFalse( new Date( 9, 10, 2000 ).isBefore( new Date( 9, 9, 2000 ) ) );
        assertFalse( new Date( 9, 10, 2000 ).isBefore( new Date( 8, 10, 2000 ) ) );
    }

    @Test(expected = IllegalArgumentException.class) public void isBeforeInvalidTests()
    {
        new Date( 1, 1, 2000 ).isBefore( null );
    }

    @Test public void isAfterTests()
    {
        assertTrue( new Date( 1, 1, 2001 ).isAfter( new Date( 1, 1, 2000 ) ) );
        assertTrue( new Date( 3, 1, 2000 ).isAfter( new Date( 2, 1, 2000 ) ) );
        assertTrue( new Date( 1, 2, 2000 ).isAfter( new Date( 1, 1, 2000 ) ) );
        assertTrue( new Date( 9, 10, 2001 ).isAfter( new Date( 9, 10, 2000 ) ) );
        assertTrue( new Date( 9, 10, 2000 ).isAfter( new Date( 9, 9, 2000 ) ) );
        assertTrue( new Date( 9, 10, 2000 ).isAfter( new Date( 8, 10, 2000 ) ) );

        assertFalse( new Date( 1, 1, 2000 ).isAfter( new Date( 1, 1, 2000 ) ) );
        assertFalse( new Date( 1, 1, 2000 ).isAfter( new Date( 1, 1, 2001 ) ) );
        assertFalse( new Date( 1, 1, 2000 ).isAfter( new Date( 1, 2, 2000 ) ) );
        assertFalse( new Date( 1, 1, 2000 ).isAfter( new Date( 2, 1, 2000 ) ) );
        assertFalse( new Date( 31, 1, 2000 ).isAfter( new Date( 1, 2, 2000 ) ) );
        assertFalse( new Date( 31, 12, 2000 ).isAfter( new Date( 1, 1, 2001 ) ) );
        assertFalse( new Date( 15, 1, 2000 ).isAfter( new Date( 16, 1, 2000 ) ) );
        assertFalse( new Date( 15, 1, 2000 ).isAfter( new Date( 15, 3, 2000 ) ) );
        assertFalse( new Date( 15, 1, 2000 ).isAfter( new Date( 15, 1, 2001 ) ) );
    }

    @Test public void isSameDateTests()
    {
        assertTrue( new Date( 1, 1, 2000 ).isSameDate( new Date( 1, 1, 2000 ) ) );
        assertTrue( new Date( 12, 12, 2012 ).isSameDate( new Date( 12, 12, 2012 ) ) );

        assertFalse( new Date( 1, 1, 2000 ).isSameDate( new Date( 1, 1, 2001 ) ) );
        assertFalse( new Date( 1, 1, 2000 ).isSameDate( new Date( 1, 2, 2000 ) ) );
        assertFalse( new Date( 1, 1, 2000 ).isSameDate( new Date( 2, 1, 2000 ) ) );
    }

    @Test(expected = IllegalArgumentException.class) public void isSameDateInvalidTests()
    {
        new Date( 1, 1, 2000 ).isSameDate( null );
    }

    @Test public void advanceSingleDayTests1()
    {
        Date date = new Date( 1, 1, 2000 );
        date.advanceSingleDay();

        assertEquals( 2, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void advanceSingleDayTests2()
    {
        Date date = new Date( 2, 1, 2000 );
        date.advanceSingleDay();

        assertEquals( 3, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void advanceSingleDayTests3()
    {
        Date date = new Date( 31, 1, 2000 );
        date.advanceSingleDay();

        assertEquals( 1, date.getDay() );
        assertEquals( 2, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void advanceSingleDayTests4()
    {
        Date date = new Date( 28, 2, 2000 );
        date.advanceSingleDay();

        assertEquals( 29, date.getDay() );
        assertEquals( 2, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void advanceSingleDayTests5()
    {
        Date date = new Date( 28, 2, 2001 );
        date.advanceSingleDay();

        assertEquals( 1, date.getDay() );
        assertEquals( 3, date.getMonth() );
        assertEquals( 2001, date.getYear() );
    }
    
    @Test public void advanceSingleDayTests6()
    {
        Date date = new Date( 30, 3, 2001 );
        date.advanceSingleDay();

        assertEquals( 31, date.getDay() );
        assertEquals( 3, date.getMonth() );
        assertEquals( 2001, date.getYear() );
    }
    
    @Test public void advanceSingleDayTests7()
    {
        Date date = new Date( 30, 4, 2001 );
        date.advanceSingleDay();

        assertEquals( 1, date.getDay() );
        assertEquals( 5, date.getMonth() );
        assertEquals( 2001, date.getYear() );
    }
    
    @Test public void advanceSingleDayTests8()
    {
        Date date = new Date( 31, 12, 2001 );
        date.advanceSingleDay();

        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2002, date.getYear() );
    }
    
    @Test public void goBackSingleDayTests1()
    {
        Date date = new Date(2, 1, 2000);
        date.goBackSingleDay();
        
        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void goBackSingleDayTests2()
    {
        Date date = new Date(1, 2, 2000);
        date.goBackSingleDay();
        
        assertEquals( 31, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }
    
    @Test public void goBackSingleDayTests3()
    {
        Date date = new Date(1, 3, 2000);
        date.goBackSingleDay();
        
        assertEquals( 29, date.getDay() );
        assertEquals( 2, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void goBackSingleDayTests4()
    {
        Date date = new Date(1, 3, 2001);
        date.goBackSingleDay();
        
        assertEquals( 28, date.getDay() );
        assertEquals( 2, date.getMonth() );
        assertEquals( 2001, date.getYear() );
    }

    @Test public void goBackSingleDayTests5()
    {
        Date date = new Date(1, 4, 2000);
        date.goBackSingleDay();
        
        assertEquals( 31, date.getDay() );
        assertEquals( 3, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void goBackSingleDayTests6()
    {
        Date date = new Date(1, 5, 2000);
        date.goBackSingleDay();
        
        assertEquals( 30, date.getDay() );
        assertEquals( 4, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }

    @Test public void goBackSingleDayTests7()
    {
        Date date = new Date(1, 1, 2000);
        date.goBackSingleDay();
        
        assertEquals( 31, date.getDay() );
        assertEquals( 12, date.getMonth() );
        assertEquals( 1999, date.getYear() );
    }    
    
    @Test public void advanceDaysTests1()
    {
        Date date = new Date(1, 1, 2000);
        date.advanceDays( 0 );
        
        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }
    
    @Test public void advanceDaysTests2()
    {
        Date date = new Date(1, 1, 2000);
        date.advanceDays( 1 );
        
        assertEquals( 2, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }
    
    @Test public void advanceDaysTests3()
    {
        Date date = new Date(1, 1, 2000);
        date.advanceDays( -1 );
        
        assertEquals( 31, date.getDay() );
        assertEquals( 12, date.getMonth() );
        assertEquals( 1999, date.getYear() );
    }

    @Test public void advanceDaysTests4()
    {
        Date date = new Date(1, 1, 2000);
        date.advanceDays( 31 );
        
        assertEquals( 1, date.getDay() );
        assertEquals( 2, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }
    
    @Test public void advanceDaysTests5()
    {
        Date date = new Date(1, 1, 2000);
        date.advanceDays( 366 );
        
        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2001, date.getYear() );
    }
    
    @Test public void advanceDaysTests6()
    {
        Date date = new Date(1, 1, 2001);
        date.advanceDays( 365 );
        
        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2002, date.getYear() );
    }
    
    @Test public void advanceDaysTests7()
    {
        Date date = new Date(1, 1, 2000);
        date.advanceDays( -365 );
        
        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 1999, date.getYear() );
    }
    
    @Test public void advanceDaysTests8()
    {
        Date date = new Date(1, 1, 2001);
        date.advanceDays( -366 );
        
        assertEquals( 1, date.getDay() );
        assertEquals( 1, date.getMonth() );
        assertEquals( 2000, date.getYear() );
    }
}
