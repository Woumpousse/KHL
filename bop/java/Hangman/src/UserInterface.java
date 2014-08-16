import javax.swing.*;

public class UserInterface
{
    public void showMessage(String message)
    {
        JOptionPane.showMessageDialog( null, message );
    }
    
    public String askString(String message)
    {
        return JOptionPane.showInputDialog( message );
    }

    public char askChar(String message)
    {
        String input;

        while ( (input = askString( message )).length() != 1 )
        {
            showMessage( "Wrong input" );
        }

        return input.charAt( 0 );
    }

    public int askInt(String message)
    {
        while ( true )
        {
            String input = askString( message );

            try
            {
                return Integer.parseInt( input );
            }
            catch ( RuntimeException e )
            {

            }
        }
    }
}
