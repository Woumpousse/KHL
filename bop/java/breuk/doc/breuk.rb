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

  def simplify(a, b)
    if b < 0
    then
      a = -a
      b = -b
    end

    gcd = a.gcd(b)

    a /= gcd
    b /= gcd

    "#{a}/#{b}"
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
      # Classes must have no access modifier!
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
end
