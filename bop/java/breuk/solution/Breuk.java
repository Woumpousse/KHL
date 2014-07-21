public class Breuk
{
    private int teller;

    private int noemer;

    public Breuk(int teller, int noemer)
    {
        if ( noemer == 0 )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            int ggd = Util.ggd( Math.abs( teller ), Math.abs( noemer ) );

            this.teller = teller / ggd;
            this.noemer = noemer / ggd;
        }
    }

    public int getTeller()
    {
        return teller;
    }

    public int getNoemer()
    {
        return noemer;
    }

    public Breuk vermenigvuldig(Breuk that)
    {
        if ( that == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            int teller = this.teller * that.teller;
            int noemer = this.noemer * that.noemer;

            return new Breuk( teller, noemer );
        }
    }

    public Breuk telOp(Breuk that)
    {
        if ( that == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            int teller = this.teller * that.noemer + this.noemer * that.teller;
            int noemer = this.noemer * that.noemer;

            return new Breuk( teller, noemer );
        }
    }

    public Breuk inverteer()
    {
        return new Breuk( this.noemer, this.teller );
    }

    public Breuk deel(Breuk that)
    {
        if ( that == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return this.vermenigvuldig( that.inverteer() );
        }
    }

    public boolean isGelijkAan(Breuk that)
    {
        if ( that == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return this.getTeller() == that.getTeller() && this.getNoemer() == that.getNoemer();
        }
    }
}
