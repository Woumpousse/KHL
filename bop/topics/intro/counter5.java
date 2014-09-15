class Counter {
    private int count;
    public void increment() {
        setCount(getCount() + 1);
    }
    public int getCount()  {
        return count;
    }
    public void reset() {
        setCount(0);
    }
    public void setCount(int newCount) {
        count = newCount;
    }
}
