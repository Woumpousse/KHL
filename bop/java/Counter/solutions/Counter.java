class Counter
{
    private int value;

    public Counter()
    {
        this.value = 0;
    }

    public void increment()
    {
        this.value += 1;
    }
    
    public void decrement()
    {
        this.value -= 1;
    }

    public int getValue()
    {
        return this.value;
    }

    public void reset()
    {
        this.value = 0;
    }
}
