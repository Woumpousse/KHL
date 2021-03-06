class Circle {
    private double radius;

    public double getRadius() {
        return radius;
    }

    public void setRadius(double newRadius) {
        radius = newRadius;
    }

    public double area() {
        return radius * radius * 3.14;
    }
}

class App {
    public static void main(String[] args) {
        Circle c = new Circle();

        // Tot 1 cijfer na de komma,
        // dus niet 5 maar 5.0 antwoorden
        System.out.println(c.getRadius());
    }
}

// ---

class Circle {
    private double radius;

    public double getRadius() {
        return radius;
    }

    public void setRadius(double newRadius) {
        radius = newRadius;
    }

    public double area() {
        return radius * radius * 3.14;
    }
}

class App {
    public static void main(String[] args) {
        Circle c = new Circle();
        
        c.setRadius(1);

        // Tot 1 cijfer na de komma,
        // dus niet 5 maar 5.0 antwoorden
        System.out.println(c.getRadius());
    }
}

// ---

class Circle {
    private double radius;

    public double getRadius() {
        return radius;
    }

    public void setRadius(double newRadius) {
        radius = newRadius;
    }

    public double area() {
        return radius * radius * 3.14;
    }
}

class App {
    public static void main(String[] args) {
        Circle c = new Circle();
        
        c.setRadius(2 * 5);

        // Tot 1 cijfer na de komma,
        // dus niet 5 maar 5.0 antwoorden
        System.out.println(c.getRadius());
    }
}

// ---

class Circle {
    private double radius;

    public double getRadius() {
        return radius;
    }

    public void setRadius(double newRadius) {
        radius = newRadius;
    }

    public double area() {
        return radius * radius * 3.14;
    }
}

class App {
    public static void main(String[] args) {
        Circle c = new Circle();
        
        c.setRadius(1);

        // Tot 2 cijfers na de komma,
        // dus niet 5 maar 5.00 antwoorden
        System.out.println(c.area());
    }
}

// ---

class Calculator {
    private int value;

    public void add(int x) {
        value += x;
    }

    public void multiply(int x) {
        value *= x;
    }

    public int getValue() {
        return value;
    }
}

class App {
    public static void main(String[] args) {
        Calculator calc = new Calculator();

        calc.add(2);
        calc.multiply(5);

        System.out.println( calc.getValue() );
    }
}

// ---

class Averager {
    private int sum;
    private int count;

    public void add(int x) {
        sum += x;
        count++;
    }

    public int getAverage() {
        return sum / count;
    }
}

class App {
    public static void main(String[] args) {
        Averager avg = new Averager();

        avg.add(1);
        avg.add(2);
        avg.add(3);
        avg.add(4);
        avg.add(5);

        System.out.println( avg.getAverage() );
    }
}

// ---

class Foo {
    private int x;
    private int y;

    public void set(int a, int b) {
        x = a;
        y = b;
    }

    public void bar() {
        int t = x;
        x = y;
        y = t;
    }

    public int getX() {
        return x;
    }

    public int getY() {
        return y;
    }
}

class App {
    public static void main(String[] args) {
        Foo foo = new Foo();

        foo.set(3, 5);
        foo.bar();

        System.out.println( foo.getX() + "," + foo.getY() );
    }
}

// ---

class Foo {
    private int x;

    public void inc() {
        x++;
    }

    public int get() {
        return x;
    }
}

class App {
    public static void main(String[] args) {
        Foo f1 = new Foo();
        Foo f2 = new Foo();

        f1.inc();
        f2.inc();
        f2.inc();

        System.out.println( f1.get() + "," + f2.get() );
    }
}
