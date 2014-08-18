public class @\X{Person}{class}@
{
    private String name@\X{;}{fieldfirst}@
    @\X{}{fieldlast}@private int age;

    public Person(String name, int age) @\X{\{}{constructorbegin}@
        this.name = name;
        this.age  = age;
    @\X{\}}{constructorend}@

    public @\X{S}{methodtop}@tring getName() {
        return name;
    }

    public void setName(String name) @\X{\{}{methodright}@
        this.name = name;
    @\X{\}}{methodbottom}@
}
