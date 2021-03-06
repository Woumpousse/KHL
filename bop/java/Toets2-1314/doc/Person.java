public class Person {
    private String firstName;
    private String lastName;

    public Person(String firstName, String lastName) {
        setFirstName(firstName);
        setLastName(lastName);
    }

    public String getFirstName() {
        return this.firstName;
    }

    public String getLastName() {
        return this.lastName;
    }

    public void setFirstName(String firstName) {
        if ( firstName == null ) abort();

        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        if ( lastName == null ) abort();

        this.lastName = lastName;
    }
}
