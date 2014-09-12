function sum(n)
{
    if ( `\NODE{n === 1}{base case check}` )
    {
        return `\NODE{1}{base case}`;
    }
    else
    {
        return `\NODE{n +}{work}` `\NODE{sum(n - 1)}{recursion}`;
    }
}
