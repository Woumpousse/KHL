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
            if ( noemer < 0 )
            {
                teller = -teller;
                noemer = -noemer;
            }
            
            int ggd = Util.ggd( Math.abs( teller ), noemer );

            this.teller = teller / ggd;
            this.noemer = noemer / ggd;
        }
    }
    
    public Breuk(int waarde)
    {
        this(waarde, 1);
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
    
    public Breuk tegengestelde()
    {
        return new Breuk(-this.teller, this.noemer);
    }
    
    public Breuk trekAf(Breuk that)
    {
        if ( that == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            return this.telOp( that.tegengestelde() );
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
   
    public boolean isNietGelijkAan(Breuk that)
    {
        return !isGelijkAan(that);
    }
    
    public boolean isStriktNegatief()
    {
        return this.getTeller() < 0;
    }
    
    public boolean isStriktPositief()
    {
        return this.getTeller() > 0;
    }
    
    public boolean isNegatief()
    {
        return this.getTeller() <= 0;
    }
    
    public boolean isPositief()
    {
        return this.getTeller() >= 0;
    }
    
    public boolean isKleinerDan(Breuk that)
    {
        return this.trekAf(that).isStriktNegatief();
    }
    
    public boolean isGroterDan(Breuk that)
    {
        return this.trekAf( that ).isStriktPositief();
    }
    
    public boolean isKleinerDanOfGelijkAan(Breuk that)
    {
        return this.trekAf(that).isNegatief();
    }
    
    public boolean isGroterDanOfGelijkAan(Breuk that)
    {
        return this.trekAf(that).isPositief();
    }
}
