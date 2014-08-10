
public class StudentProgramma
{
    public static void main(String[] args)
    {
        Student student = new Student("Janssen", "Anne", 532145);
        OPO opo1 = new OPO(3060, "Beginselen van objectgericht programmeren", 6);
        OPO opo2 = new OPO(2030, "Computer architecture", 4, true);
        Jaarprogramma jaarprogramma = new Jaarprogramma( student );
        jaarprogramma.voegInschrijvingToe( 16, 9, 2014, opo1 );
        jaarprogramma.voegInschrijvingToe( 22, 9, 2014, opo2 );
        
        System.out.println(jaarprogramma.geefFactuur());
    }
}
