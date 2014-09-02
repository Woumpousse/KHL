public class Wagon
{
    private int capacity;

    private Wagon tail;

    public Wagon(int capacity)
    {
        setCapacity( capacity );
    }

    public int getCapacity()
    {
        return capacity;
    }

    public Wagon getTail()
    {
        return this.tail;
    }

    private void setCapacity(int capacity)
    {
        if ( capacity < 0 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.capacity = capacity;
        }
    }

    public void attach(Wagon wagon)
    {
        if ( wagon == null || wagon.containsWagon( this ) )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.tail = wagon;
        }
    }

    public void detach()
    {
        if ( isLast() )
        {
            throw new IllegalStateException();
        }
        else
        {
            this.tail = null;
        }
    }

    private boolean containsWagon(Wagon wagon)
    {
        return this == wagon || (getTail() != null && getTail().containsWagon( wagon ));
    }

    public int getLength()
    {
        int tailLength;

        if ( isLast() )
        {
            tailLength = 0;
        }
        else
        {
            tailLength = this.getTail().getLength();
        }

        return 1 + tailLength;
    }

    public int getTotalCapacity()
    {
        int tailTotalCapacity;

        if ( tail == null )
        {
            tailTotalCapacity = 0;
        }
        else
        {
            tailTotalCapacity = this.getTail().getTotalCapacity();
        }

        return this.getCapacity() + tailTotalCapacity;
    }

    public Wagon detachLast()
    {
        if ( this.getTail() == null )
        {
            throw new IllegalStateException();
        }
        else if ( this.getTail().isLast() )
        {
            Wagon tail = getTail();
            detach();
            return tail;
        }
        else
        {
            return this.getTail().detachLast();
        }
    }

    public boolean isLast()
    {
        return getTail() == null;
    }

    public Wagon nth(int n)
    {
        if ( n == 0 )
        {
            return this;
        }
        else if ( getTail() == null || n < 0 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return getTail().nth( n - 1 );
        }
    }
    
    public Wagon last()
    {
        if ( isLast() )
        {
            return this;
        }
        else
        {
            return getTail().last();
        }
    }

    public void join(Wagon train)
    {
        last().attach( train );
    }

    public Wagon keepWagons(int n)
    {
        if ( n < 1 )
        {
            throw new IllegalArgumentException();
        }
        else if ( n == 1 )
        {
            Wagon tail = getTail();
            
            detach();
            
            return tail;
        }
        else if ( !isLast() )
        {
            return getTail().keepWagons(n-1);
        }
        else
        {
            return null;
        }
    }
    
    public Wagon takeWagonCapacity(int n)
    {
        if ( getCapacity() >= n )
        {
            Wagon tail = getTail();
            
            detach();
            
            return tail;
        }
        else if ( isLast() )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return getTail().takeWagonCapacity( n - this.getCapacity() );
        }
    }
    
    public boolean sameTrain(Wagon that)
    {
        if ( that == null )
        {
            return false;
        }
        else if ( this.getCapacity() != that.getCapacity() )
        {
            return false;
        }
        else if ( this.isLast() )
        {
            return that.isLast();
        }
        else
        {
            return this.getTail().sameTrain( that.getTail() );
        }
    }
}
