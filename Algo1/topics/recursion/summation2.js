function sum(n)
{
    // Beter basisgeval
    if ( n === 0 )
    {
        return 0;
    }
    else
    {
        return n + sum(n - 1);
    }
}
