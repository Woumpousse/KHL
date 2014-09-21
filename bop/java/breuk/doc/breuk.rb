require './Questions.rb'
require './Controller.rb'
require './Shared.rb'
require './Parameters.rb'

class Resources < Controller

  def fields
    once(__method__) do
      Questions::Java::AutoFillInTypes.new.parse( <<-'END'.unindent.strip )
        class Breuk
        {
            private int teller;
            private int noemer;
        }   
      END
    end
  end

  def frac_s(a, b)
    "#{a}/#{b}"
  end

  def simplify_s(a, b)
    a, b = simplify(a, b)

    frac_s(a, b)
  end

  def simplify(a, b)
    if b < 0
    then
      a = -a
      b = -b
    end

    gcd = a.gcd(b)

    a /= gcd
    b /= gcd

    [a, b]
  end

  def format(code)
    HTML::Formatters::JavaFormatter.new.apply(code.unindent)
  end

  def getter_code
    format(<<-'END')
        class Breuk {
            private int teller;
            private int noemer;

            public int getTeller() {
                return teller;
            }
        }
    END
  end

  def getTeller_code
    format(<<-'END')
      Breuk breuk = new Breuk();
      int teller = breuk.getTeller();
    END
  end

  def getTeller_code2
    format(<<-'END')
      Breuk b = new Breuk();
      int t = b.getTeller();
    END
  end

  def getters_code
    format(<<-'END')
      Breuk breuk = new Breuk();
      int teller = breuk.getTeller();
      int noemer = breuk.getNoemer();
    END
  end

  def constructor_code
    format(<<-'END')
      class Breuk {
          // Velden
          private int teller;
          private int noemer;

          // Constructor
          public Breuk(int a, int b) {
              teller = a;
              noemer = b;
          }
        }
    END
  end

  def breuk_creation
    format(<<-'END')
      Breuk b1 = new Breuk(); // Fout! Ontbrekende argumenten
      Breuk b2 = new Breuk(1, 2); // Correct, maakt breuk 1/2 aan
    END
  end

  def interpret_creation
    once(__method__) do
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip, <<-'BACKGROUND'.unindent )
        class App
        {
            public static void main(String[] args)
            {
                Breuk breuk = new Breuk(1, 2);

                System.out.println( breuk.getTeller() + "/" + breuk.getNoemer() );
            }
        }
      END
        class Breuk {
            private int teller;
            private int noemer;

            public Breuk(int teller, int noemer) {
                this.teller = teller;
                this.noemer = noemer;
            }

            public int getTeller() {
                return this.teller;
            }

            public int getNoemer() {
                return this.noemer;
            }
        }
      BACKGROUND
    end
  end

  def breuk
    IO.read('Breuk.java')
  end

  def interpret_canonical
    once(__method__) do
      Questions::Java::InterpretCode.new.parse( <<-'END'.unindent.strip, breuk )
        class App
        {
            public static void main(String[] args)
            {
                Breuk breuk = new Breuk(5, -15);

                System.out.println( breuk.getTeller() + "/" + breuk.getNoemer() );
            }
        }
      END
    end
  end

  def constructor_this
    format(<<-'END')
      class Breuk {
          private int teller;
          private int noemer;

          public Breuk(int a, int b) { ... }

          public Breuk(int a) {
              // Roept de andere constructor op
              this(a, 1);
          }
      }
    END
  end

  def opposite(a, b)
    a, b = simplify(a, b)

    [ -a, b ]
  end

  def opposite_s(a, b)
    a, b = opposite(a, b)

    frac_s(a, b)
  end

  def opposite_code
    format(<<-'END')
      class Breuk {
          // ...

          public Breuk tegengestelde() {
              return new Breuk( -teller, noemer );
          }
      }
    END
  end

  def invert(a, b)
    [b, a]
  end

  def invert_s(a, b)
    a, b = invert(a, b)

    frac_s(a, b)
  end

  def addition_code
    format(<<-'END')
      class Breuk {
          // ...

          public Breuk telOp(Breuk andere) {
              int a = teller * andere.getNoemer() + noemer * andere.getTeller();
              int b = noemer * andere.getNoemer();

              return new Breuk(a, b);
          }
      }
    END
  end

  def telOp_code
    format(<<-'END')
      Breuk b1 = new Breuk(a, b);
      Breuk b2 = new Breuk(c, d);

      Breuk som = b1.telOp(b2);
    END
  end

  def trekAf_code
    format(<<-'END')
      class Breuk {
          // ...

          public Breuk trekAf(Breuk andere) {
              return telOp( andere.tegengestelde() );
          }
      }
    END
  end
end
