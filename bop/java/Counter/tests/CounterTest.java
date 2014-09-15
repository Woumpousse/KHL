import static org.junit.Assert.*;

import org.junit.*;


public class CounterTest
{
    @Test
    public void constructor()
    {
        Counter counter = new Counter();
        
        assertEquals(0, counter.getValue());
    }
    
    @Test
    public void increment()
    {
        Counter counter = new Counter();
        
        counter.increment();
        
        assertEquals(1, counter.getValue());
    }
    
    @Test
    public void incrementFourTimes()
    {
        Counter counter = new Counter();
        
        counter.increment();
        counter.increment();
        counter.increment();
        counter.increment();
        
        assertEquals(4, counter.getValue());
    }
    
    @Test
    public void reset()
    {
        Counter counter = new Counter();
        
        counter.increment();
        counter.increment();
        counter.increment();
        counter.increment();
        
        counter.reset();
        
        assertEquals(0, counter.getValue());
    }
    
    @Test
    public void decrement()
    {
        // Aanmaak Counter-object
        Counter counter = new Counter();
        
        // Incrementeren, 0 -> 1
        counter.increment();
        
        // Decrementer, 1 -> 0
        counter.decrement();
        
        // Verifieer dat counter op 0 staat
        assertEquals(0, counter.getValue());
    }
}
