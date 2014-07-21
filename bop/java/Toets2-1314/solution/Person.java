public class Person
{
    private String firstName;
    private String lastName;

    public Person(String firstName, String lastName)
    {
        setFirstName( firstName );
        setLastName( lastName );
    }

    public String getFirstName()
    {
        return this.firstName;
    }

    public String getLastName()
    {
        return this.lastName;
    }

    public void setFirstName(String firstName)
    {
        if ( firstName == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.firstName = firstName;
        }
    }

    public void setLastName(String lastName)
    {
        if ( lastName == null )
        {
            throw new IllegalArgumentException();
        }
        else
        {
            this.lastName = lastName;
        }
    }
}
