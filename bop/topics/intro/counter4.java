class Counter {
    private int count;
    public void increment() {
        count = count + 1;
    }
    public int getCount()  {
        return count;
    }
    public void reset() {
        count = 0;
    }
    public void setCount(int newCount) {
        count = newCount;
    }
}
