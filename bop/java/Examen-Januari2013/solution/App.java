
public class App
{
    public static void main(String[] args)
    {
        Kind jan = new Kind("Jan", "Janssens", new Datum(1,1,2014));
        Kind piet = new Kind("Piet", "Peeters", new Datum(2,2,2014));
        Kind an = new Kind("An", "Willems", new Datum(3,3,2014));
        
        Verblijf verblijf = new Verblijf();
        verblijf.schrijfIn( new Inschrijving( jan, new Datum(1,1,2015), true, true) );
        verblijf.schrijfIn( new Inschrijving( jan, new Datum(2,1,2015), true, true) );
        verblijf.schrijfIn( new Inschrijving( piet, new Datum(1,1,2015), true, false) );
        verblijf.schrijfIn( new Inschrijving( an, new Datum(1,1,2015), false, true) );
        
        System.out.println( verblijf.kost( jan ) );
    }
}
