import static org.junit.Assert.*;

import org.junit.*;

public class WagonTest
{
    @Test
    public void constructor()
    {
        int capacity = 5;
        Wagon wagon = new Wagon( capacity );

        assertEquals( capacity, wagon.getCapacity() );
        assertNull( wagon.getTail() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void constructorWithInvalidCapacity()
    {
        new Wagon( -5 );
    }

    @Test
    public void attach()
    {
        Wagon w1 = new Wagon( 5 );
        Wagon w2 = new Wagon( 10 );

        w1.attach( w2 );

        assertSame( w2, w1.getTail() );
    }

    @Test(expected = IllegalArgumentException.class)
    public void attachNullWagon()
    {
        Wagon w1 = new Wagon( 5 );

        w1.attach( null );
    }

    /*
     * Moeilijkere oefening
     */
    @Test(expected = IllegalArgumentException.class)
    public void attachMakeCycle()
    {
        Wagon[] train = createTrain( 1, 2, 3 );

        train[2].attach( train[0] );
    }

    @Test
    public void detach()
    {
        Wagon[] train = createTrain( 1, 2 );

        train[0].detach();

        assertNull( train[0].getTail() );
    }

    @Test(expected = IllegalStateException.class)
    public void detachLastWagon()
    {
        Wagon w = new Wagon( 1 );

        w.detach();
    }

    @Test
    public void length1()
    {
        Wagon[] train = createTrain( 1 );

        assertEquals( 1, train[0].getLength() );
    }

    @Test
    public void length2()
    {
        Wagon[] train = createTrain( 1, 2 );

        assertEquals( 2, train[0].getLength() );
    }

    @Test
    public void length5()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );

        assertEquals( 5, train[0].getLength() );
    }

    @Test
    public void isLast()
    {
        Wagon[] train = createTrain( 1, 2, 3 );

        assertFalse( train[0].isLast() );
        assertFalse( train[1].isLast() );
        assertTrue( train[2].isLast() );
    }

    @Test
    public void totalCapacitySingleWagon()
    {
        Wagon[] train = createTrain( 5 );

        assertEquals( 5, train[0].getTotalCapacity() );
    }

    @Test
    public void totalCapacityTwoWagons()
    {
        Wagon[] train = createTrain( 5, 6 );

        assertEquals( 5 + 6, train[0].getTotalCapacity() );
    }

    @Test
    public void totalCapacityFiveWagons()
    {
        Wagon[] train = createTrain( 5, 6, 1, 2, 4 );

        assertEquals( 5 + 6 + 1 + 2 + 4, train[0].getTotalCapacity() );
    }

    @Test
    public void detachLast()
    {
        Wagon[] train = createTrain( 1, 2, 3 );

        Wagon detached = train[0].detachLast();

        assertNull( train[1].getTail() );
        assertTrue( train[1].isLast() );
        assertSame( train[2], detached );
    }

    @Test(expected = IllegalStateException.class)
    public void detachLastAtLast()
    {
        Wagon[] train = createTrain( 1 );

        train[0].detachLast();
    }

    @Test
    public void nth0()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );

        assertSame( train[0], train[0].nth( 0 ) );
    }

    @Test
    public void nth1()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );

        assertSame( train[1], train[0].nth( 1 ) );
    }

    @Test
    public void nth4()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );

        assertSame( train[4], train[0].nth( 4 ) );
    }

    @Test(expected = IllegalArgumentException.class)
    public void nthTooHigh()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );

        train[0].nth( 10 );
    }

    @Test(expected = IllegalArgumentException.class)
    public void nthTooLow()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );

        train[0].nth( -1 );
    }

    @Test
    public void last()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );

        assertSame( train[4], train[0].last() );
        assertSame( train[4], train[4].last() );
    }

    @Test
    public void join()
    {
        Wagon[] t1 = createTrain( 1, 2, 3 );
        Wagon[] t2 = createTrain( 4, 5 );

        t1[0].join( t2[0] );

        assertEquals( 5, t1[0].getLength() );
        assertSame( t2[0], t1[2].getTail() );
    }

    @Test
    public void keepWagons()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );
        Wagon result = train[0].keepWagons( 3 );

        assertEquals( 3, train[0].getLength() );
        assertSame( train[3], result );
    }

    @Test(expected = IllegalArgumentException.class)
    public void keepWagonsTooLow()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );
        train[0].keepWagons( 0 );
    }

    @Test
    public void keepWagonsTooHigh()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );
        Wagon result = train[0].keepWagons( 10 );

        assertEquals( 5, train[0].getLength() );
        assertNull( result );
    }
    
    @Test
    public void takeWagonCapacityZero()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );
        Wagon result = train[0].takeWagonCapacity( 0 );

        assertEquals( 1, train[0].getLength() );
        assertSame( train[1], result );
    }

    @Test
    public void takeWagonCapacityPerfectFit()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );
        Wagon result = train[0].takeWagonCapacity( 3 );

        assertEquals( 2, train[0].getLength() );
        assertSame( train[2], result );
    }

    @Test
    public void takeWagonCapacityImperfectFit()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );
        Wagon result = train[0].takeWagonCapacity( 4 );

        assertEquals( 3, train[0].getLength() );
        assertSame( train[3], result );
    }

    @Test(expected = IllegalArgumentException.class)
    public void takeWagonCapacityTooMuch()
    {
        Wagon[] train = createTrain( 1, 2, 3, 4, 5 );
        train[0].takeWagonCapacity( 16 );
    }

    @Test
    public void sameTrain()
    {
        Wagon[] t1 = createTrain( 1, 2, 3 );
        Wagon[] t2 = createTrain( 1, 2, 3 );

        assertTrue( t1[0].sameTrain( t2[0] ) );
        assertTrue( t2[0].sameTrain( t1[0] ) );
    }

    @Test
    public void sameTrainDifferentLengths()
    {
        Wagon[] t1 = createTrain( 1, 2, 3 );
        Wagon[] t2 = createTrain( 1, 2, 3, 4 );

        assertFalse( t1[0].sameTrain( t2[0] ) );
        assertFalse( t2[0].sameTrain( t1[0] ) );
    }

    @Test
    public void sameTrainDifferentCapacities()
    {
        Wagon[] t1 = createTrain( 1, 2, 3 );
        Wagon[] t2 = createTrain( 1, 2, 4 );

        assertFalse( t1[0].sameTrain( t2[0] ) );
        assertFalse( t2[0].sameTrain( t1[0] ) );
    }

    private static Wagon[] createTrain(int... capacities)
    {
        Wagon[] train = new Wagon[capacities.length];

        for ( int i = train.length - 1; i >= 0; --i )
        {
            train[i] = new Wagon( capacities[i] );

            if ( i + 1 < train.length )
            {
                train[i].attach( train[i + 1] );
            }
        }

        return train;
    }
}
